class AddUserMatch < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :user_id
      t.string :matched_with

      t.timestamps
    end

    remove_column :users, :matched_with, :string
    remove_column :users, :matched_at, :datetime

    add_column :users, :active, :boolean, default: true
  end
end
