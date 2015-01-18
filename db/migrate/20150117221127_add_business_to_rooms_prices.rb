class AddBusinessToRoomsPrices < ActiveRecord::Migration
  def change
      add_reference :rooms_prices, :business, index: true
      add_reference :rooms_prices, :room, index: true
  end
end
