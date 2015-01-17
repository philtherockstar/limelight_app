class Realtor < ActiveRecord::Base
	belongs_to :business
	has_and_belongs_to_many :bids
end
