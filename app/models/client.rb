class Client < ActiveRecord::Base
	belongs_to :business
	has_many :consultations
	has_and_belongs_to_many :bids
	def display_name
        "#{first_name} #{last_name}"
	end
end
