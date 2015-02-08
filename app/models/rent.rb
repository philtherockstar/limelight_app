class Rent < ActiveRecord::Base
  belongs_to :property
  belongs_to :stage
end
