class AddBusinessToRoomPrices < ActiveRecord::Migration
  def change
      add_reference :room_prices, :business, index: true
      add_reference :room_prices, :room, index: true
  end
end
