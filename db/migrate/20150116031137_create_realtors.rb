class CreateRealtors < ActiveRecord::Migration
  def change
    create_table :realtors do |t|
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :phone
      t.string :email
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
