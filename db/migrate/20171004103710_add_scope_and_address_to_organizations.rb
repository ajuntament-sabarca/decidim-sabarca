class AddScopeAndAddressToOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_user_groups, :scope_id, :integer
    add_column :decidim_user_groups, :address, :text
    add_column :decidim_user_groups, :latitude, :float
    add_column :decidim_user_groups, :longitude, :float
  end
end
