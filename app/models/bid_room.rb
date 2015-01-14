class BidRoom < ActiveRecord::Base
  belongs_to :bid
  belongs_to :room
  has_many :bid_room_items
  validates :num_rooms, numericality: { only_integer: true, less_than: 11 }
end
