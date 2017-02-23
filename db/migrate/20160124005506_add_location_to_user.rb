class AddLocationToUser < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :city
      t.string :state
      t.string :state_abbreviation

      t.timestamps null: false
    end

    remove_column :users, :location
    add_column :users, :location_id, :integer
  end
end
