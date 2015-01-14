class Bid < ActiveRecord::Base
  belongs_to :property
  has_many :bid_rooms
end
