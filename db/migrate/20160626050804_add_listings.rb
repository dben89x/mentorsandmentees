class AddListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.references :listable,       polymorphic: true, index: true
      t.string   'position_name'
      t.string   'posting_link'
      t.string   'contact_name'
      t.string   'contact_email'
      t.text     'description'
      t.integer  'hours_per_week'
      t.string   'category_id'
      t.integer  'location_id'
      t.boolean  'active',         default: true
      t.timestamps                 null: false
    end
  end
end
