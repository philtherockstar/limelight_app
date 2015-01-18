class CreateRoomPrices < ActiveRecord::Migration
  def change
    create_table :room_prices do |t|
      t.decimal :price
      t.timestamps null: false
    end
  end
end
class AddBusinessToRoomsPrices < ActiveRecord::Migration
  def change
      add_reference :rooms_prices, :business, index: true
      add_reference :rooms_prices, :room, index: true
  end
end
