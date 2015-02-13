class Stage < ActiveRecord::Base

    attr_accessor :extended_rental, :rent_due, :rent_due_on
    has_many :rents
	belongs_to :bid
	belongs_to :property
	belongs_to :realtor

	def initilize
		super
		in_extended_rental?
    end

    def in_extended_rental?
    	puts "in_extended_rental"
    	if stage_date.advance(:days => 60-7) < Date.today
    		@extended_rental = true
        else
        	@extended_rental = false
    	end
    end

	def rent_due?
	  rent_is_due=false
	  if in_extended_rental?
	  	# rent has never been paid, enter a row for rent due
	  	rents_count = rents.size
	  	puts "rents_count=#{rents_count.to_s}"
        if rents_count == 0
        	Rent.transaction do
	        	rent_due_on = stage_date.advance(:months => 2)
	        	r = Rent.new
	        	r.property_id = property_id
	        	r.stage_id = id
	        	r.rent_due = monthly_rental
	        	r.rent_due_on = rent_due_on
	        	r.save
	        	rent_is_due = true
	        end

        else

           rent_due_on = stage_date.advance(:months => rents_count + 2)
           puts "rent_due_on = #{rent_due_on.to_s}"
           r = Rent.where("stage_id = #{id} and rent_due_on = ?", rent_due_on)
           if r.size == 0 
	        	Rent.transaction do
		        	rent_due_on = stage_date.advance(:months => rents_count + 2)
		        	r = Rent.new
		        	r.property_id = property_id
		        	r.stage_id = id
		        	r.rent_due = monthly_rental
		        	r.rent_due_on = rent_due_on
		        	r.save
		        	rent_is_due = true
		        end
           
           elsif r.first.rent_paid.nil?
           	 rent_is_due = true
           end

        end

	  end

      rent_is_due

	end

end
