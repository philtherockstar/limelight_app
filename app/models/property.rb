class Property < ActiveRecord::Base
  belongs_to :business
  has_many :bids
  has_many :stages
  has_many :rents
  validates :address, :city, presence: true
  belongs_to :state
  belongs_to :country
  belongs_to :status
end
