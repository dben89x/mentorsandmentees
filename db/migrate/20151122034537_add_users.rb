class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :first_name
      t.string   :last_name
      t.string   :linked_in
      t.text     :skills, array: true, default: []
      t.string   :location
      t.integer  :hours_per_week
      t.string   :email
      t.string   :role
      t.string   :category_id
      t.string   :matched_with
      t.datetime :matched_at

      t.string   :password_digest
      t.string   :remember_digest
      t.string   :activation_digest
      t.boolean  :activated,         default: false
      t.datetime :activated_at

      t.timestamps null: false
    end
  end
end
