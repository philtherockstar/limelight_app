class AddDetailsToBids < ActiveRecord::Migration
  def change
    add_column :bids, :rental_weeks, :integer
  end
end
