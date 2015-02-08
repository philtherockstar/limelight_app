class Stage < ActiveRecord::Base
        has_many :rents
	belongs_to :bid
	belongs_to :property
	belongs_to :realtor
end
