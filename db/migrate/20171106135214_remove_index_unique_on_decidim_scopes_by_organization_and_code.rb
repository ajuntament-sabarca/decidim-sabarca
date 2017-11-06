class RemoveIndexUniqueOnDecidimScopesByOrganizationAndCode < ActiveRecord::Migration[5.0]
  def change
    remove_index :decidim_scopes, [:decidim_organization_id, :code] if index_name_exists?(:decidim_scopes, "index_decidim_scopes_on_decidim_organization_id_and_code")
  end
end
