class Consultation < ActiveRecord::Base
	belongs_to :property
	belongs_to :client
	belongs_to :realtor
end
