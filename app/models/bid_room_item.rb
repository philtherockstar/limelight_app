class BidRoomItem < ActiveRecord::Base
  belongs_to :bid
  belongs_to :bid_room
  belongs_to :room
  belongs_to :item
end
