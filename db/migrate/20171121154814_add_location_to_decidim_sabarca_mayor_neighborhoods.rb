class AddLocationToDecidimSabarcaMayorNeighborhoods < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_sabarca_mayor_neighborhoods, :location, :jsonb
  end
end
