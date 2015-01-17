class CreateBidsAndClients < ActiveRecord::Migration
  def change
    create_table :bids_clients, id: false do |t|
      t.belongs_to :bid, index: true
      t.belongs_to :client, index: true
    end
  end
end
