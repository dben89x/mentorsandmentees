class CreateFeaturedStartups < ActiveRecord::Migration
  def change
    create_table :featured_startups do |t|
      t.belongs_to :startup_profile, index: true
      t.timestamps
    end
  end
end
