class CreateRoomsPrice < ActiveRecord::Migration
  def change
    create_table :rooms_prices do |t|
      t.decimal :price
    end
  end
  def self.down
    drop_table :rooms_prices
  end
end
