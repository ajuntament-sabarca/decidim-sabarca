module Decidim
  module Sabarca
    module MayorNeighborhoodsHelper

      def static_map_link(resource, options = {})
        return unless resource.geocoded?

        zoom = options[:zoom] || 17
        latitude = resource.latitude
        longitude = resource.longitude

        map_url = "https://www.openstreetmap.org/?mlat=#{latitude}&mlon=#{longitude}#map=#{zoom}/#{latitude}/#{longitude}"

        link_to map_url, target: "_blank" do
          image_tag decidim.static_map_path(sgid: resource.to_sgid.to_s)
        end
      end

    end
  end
end
