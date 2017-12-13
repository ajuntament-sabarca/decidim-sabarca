class AddLinkToUserGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_user_groups, :url, :text
  end
end
