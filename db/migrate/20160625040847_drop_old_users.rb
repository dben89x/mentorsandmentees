class DropOldUsers < ActiveRecord::Migration
  def up
    drop_table :users
  end

  def down
    create_table do |t|
      t.string   "first_name"
      t.string   "last_name"
      t.string   "linked_in"
      t.integer  "hours_per_week"
      t.string   "email"
      t.string   "role"
      t.string   "category_id"
      t.string   "password_digest"
      t.string   "remember_digest"
      t.string   "activation_digest"
      t.boolean  "activated",        default: false
      t.datetime "activated_at"
      t.string   "company_name"
      t.string   "company_website"
      t.string   "position"
      t.string   "paid"
      t.string   "company_phone"
      t.string   "type"
      t.integer  "location_id"
      t.boolean  "active",           default: true
      t.timestamps                   null: false
    end
  end
end
