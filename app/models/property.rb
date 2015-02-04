class Property < ActiveRecord::Base
  belongs_to :business
  has_many :bids
  validates :address, :city, presence: true
  belongs_to :state
  belongs_to :country
  belongs_to :status
end
