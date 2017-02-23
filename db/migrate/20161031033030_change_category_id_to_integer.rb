class ChangeCategoryIdToInteger < ActiveRecord::Migration
  def change
    # change_table :listings do |t|
    #   t.change :category_id, :integer
    # end

    change_column :listings, :category_id, 'integer USING CAST(category_id AS integer)'
  end
end
