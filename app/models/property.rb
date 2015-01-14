class Property < ActiveRecord::Base
  belongs_to :business
  has_many :bids
  validates :address, :city, presence: true  
end
