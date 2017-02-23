class AddCompanies < ActiveRecord::Migration
  def change
    add_column :users, :company_name,    :string
    add_column :users, :company_website, :string
    add_column :users, :position,        :string
    add_column :users, :paid,            :string
    add_column :users, :company_phone,   :string
    add_column :users, :type,            :string
  end
end
