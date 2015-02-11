class Stage < ActiveRecord::Base

    attr_accessor :rent_due, :rent_due_on
    has_many :rents
	belongs_to :bid
	belongs_to :property
	belongs_to :realtor

	def rent_due?
	
	  nil

	end

end
