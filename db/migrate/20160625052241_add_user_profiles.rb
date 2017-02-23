class AddUserProfiles < ActiveRecord::Migration
  def change
    create_table :intern_profiles do |t|
      t.references 'user'
      t.string   'first_name'
      t.string   'last_name'
      t.string   'linked_in'
      t.timestamps                 null: false
    end

    create_table :startup_profiles do |t|
      t.references 'user'
      t.string  'company_name'
      t.string  'company_website'
      t.timestamps                null: false
    end
  end
end
