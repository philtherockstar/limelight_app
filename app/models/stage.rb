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
	
	  nil

	end

end
