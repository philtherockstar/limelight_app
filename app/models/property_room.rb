class PropertyRoom < ActiveRecord::Base
  belongs_to :room
  belongs_to :property
end
