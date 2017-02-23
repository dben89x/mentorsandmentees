class RefactorMatches < ActiveRecord::Migration
  def up
    drop_table :matches

    create_table :matches do |t|
      t.references :matchable, polymorphic: true, index: true
      t.string :matched_with

      t.timestamps
    end
  end

  def down
    drop_table :matches

    create_table :matches do |t|
      t.integer :user_id
      t.string :matched_with

      t.timestamps
    end
  end
end
