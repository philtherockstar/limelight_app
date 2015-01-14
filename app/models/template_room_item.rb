class TemplateRoomItem < ActiveRecord::Base
  belongs_to :business
  belongs_to :room
  belongs_to :item
end
