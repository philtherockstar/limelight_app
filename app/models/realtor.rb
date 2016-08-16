class Realtor < ActiveRecord::Base
	belongs_to :business
	has_and_belongs_to_many :bids
	has_many :stages
	has_many :consultations
	def display_name
        "#{first_name} #{last_name}"
	end
end
