class Business < ActiveRecord::Base
  has_many :users
  has_many :clients
  has_many :realtors
  has_many :business_cities
  has_many :properties
  has_many :template_room_items
end
