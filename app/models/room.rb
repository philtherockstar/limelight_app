class Room < ActiveRecord::Base
  has_many :property_rooms
  has_many :template_room_items
end
