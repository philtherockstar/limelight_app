class Stage < ActiveRecord::Base
	belongs_to :bid
	belongs_to :property
	belongs_to :realtor
end
