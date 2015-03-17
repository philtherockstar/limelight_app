class Client < ActiveRecord::Base
	belongs_to :business
	has_many :consultations
	has_many :contracts
	has_and_belongs_to_many :bids
end
