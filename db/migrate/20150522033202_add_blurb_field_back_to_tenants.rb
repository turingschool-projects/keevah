class AddBlurbFieldBackToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :blurb, :text
  end
end
