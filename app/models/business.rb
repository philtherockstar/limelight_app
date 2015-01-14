class Business < ActiveRecord::Base
  has_many :business_cities
  has_many :properties
  has_many :template_room_items
end
