class Bid < ActiveRecord::Base
  belongs_to :property
  belongs_to :bidstatus
  has_many :bid_rooms
  has_one :stage
  has_and_belongs_to_many :clients
  has_and_belongs_to_many :realtors

  def self.find_outstanding_bids
    find_by_sql("select b.* from bids as b join properties as p on b.property_id = p.id 
                                          where p.status_id is null and (b.bidstatus_id is null or b.bidstatus_id <= 3)
                                          and b.bid_date >= '#{1.year.ago}'
                                          order by b.bid_date desc")
  end
end
