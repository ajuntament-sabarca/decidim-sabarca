# frozen_string_literal: true

class CreateDecidimSabarcaTransparencyItems < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_sabarca_transparency_items do |t|
      t.jsonb :text
      t.jsonb :url
      t.integer :position
      t.references :decidim_organization, index: { name: "index_transparency_item_organization_id" }

      t.timestamps
    end
  end
end
