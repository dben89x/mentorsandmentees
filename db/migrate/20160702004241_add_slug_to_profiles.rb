class AddSlugToProfiles < ActiveRecord::Migration
  def change
    add_column :startup_profiles, :slug, :string
    add_index  :startup_profiles, :slug, unique: true

    add_column :intern_profiles, :slug, :string
    add_index  :intern_profiles, :slug, unique: true
  end
end
