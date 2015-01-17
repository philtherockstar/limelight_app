class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.string :index

      t.timestamps null: false
    end
  end
end
