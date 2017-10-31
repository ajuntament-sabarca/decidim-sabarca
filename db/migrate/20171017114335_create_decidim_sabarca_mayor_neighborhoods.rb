class CreateDecidimSabarcaMayorNeighborhoods < ActiveRecord::Migration[5.1]
  def change
    create_table :decidim_sabarca_mayor_neighborhoods do |t|
      t.jsonb :title
      t.jsonb :description
      t.jsonb :councilors
      t.jsonb :topics
      t.string :slug
      t.datetime :start_time
      t.datetime :end_time
      t.text :address
      t.float :latitude
      t.float :longitude
      t.references :decidim_organization, index: { name: "index_decidim_neighborhood_on_decidim_organization_id" }
      t.references :decidim_scope, index: { name: "index_decidim_neighborhood_on_decidim_scope_id" }

      t.timestamps

    end
  end
end
