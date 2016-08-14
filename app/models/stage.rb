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
    	if stage_date.advance(:days => 60-7) <= Date.today
    		@extended_rental = true
        else
        	@extended_rental = false
        	@rent_due_on = stage_date.advance(:months => 2)
    	end
    	@extended_rental
    end

	def rent_due?
	  rent_is_due=false
	  create_new_rent_record=false
	  if in_extended_rental?
	  	# rent has never been paid, enter a row for rent due


	  	# maybe query where rent due on. if not there insert the record
	  	# rent due on will be different based on how many rent records we have
	  	# if 0, rent due in 2 months
	  	# 
	  	rents_count = rents.size
	  	#puts "rents_count=#{rents_count.to_s}"
        if rents_count == 0
            @rent_due_on = stage_date.advance(:months => 2)
            make_new_rent_record = true
            rent_is_due = true
        elsif rents_count > 0
        	#puts "count > 0. last record is #{rents.last.inspect}"
            if rents.last.rent_paid.nil?
            	#puts "last rent was not paid"
            	#@rent_due_on = stage_date.advance(:months => rents_count + 1)
                @rent_due_on = rents.last.rent_due_on
            	rent_is_due = true
            else
            	#puts "last rent was paid"
            	@rent_due_on = stage_date.advance(:months => rents_count + 2)
            	#puts "new rent due date is #{rent_due_on.inspect}"
            	#puts "#{@rent_due_on.advance(:days => -7)} <= #{Date.today}"
            	if @rent_due_on.advance(:days => -7) <= Date.today
            		#puts "time to collect rent. making new recrod and rent is now due"
            		make_new_rent_record = true
            		rent_is_due = true
            	end
            end
        end

        if make_new_rent_record
            #puts "making new rent record"
        	Rent.transaction do

	        	r = Rent.new
	        	r.property_id = property_id
	        	r.stage_id = id
	        	r.rent_due = monthly_rental
	        	r.rent_due_on = @rent_due_on
	        	r.save

	        end

	    end

      end
      rent_is_due

	end

end
