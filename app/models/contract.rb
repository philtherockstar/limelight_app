class Contract < ActiveRecord::Base
  belongs_to :property
  belongs_to :bid
  belongs_to :client
end
