class Bid < ActiveRecord::Base
  belongs_to :property
  has_many :bid_rooms
  has_one :stage
  has_and_belongs_to_many :clients
  has_and_belongs_to_many :realtors
end
