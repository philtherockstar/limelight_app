class CreateBidsRealtors < ActiveRecord::Migration
  def change
    create_table :bids_realtors, id: false do |t|
      t.belongs_to :bid, index: true
      t.belongs_to :realtor, index: true
    end
  end
  def self.down
    drop table :bids_realtors
  end
end
