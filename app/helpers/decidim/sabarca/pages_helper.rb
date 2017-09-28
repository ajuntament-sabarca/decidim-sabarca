module Decidim
  module Sabarca
    module PagesHelper
      def scopes_map_for
        # def scopes_map_for(markers_data)
        return if Decidim.geocoder.blank?

        map_html_options = {
          class: "google-map",
          id: "map",
          # "data-markers-data" => [50.5, 30.5],
          "data-here-app-id" => Decidim.geocoder[:here_app_id],
          "data-here-app-code" => Decidim.geocoder[:here_app_code]
        }
        # content = capture { yield }
        content_tag :div, class: "row column" do
          content_tag(:div, "", map_html_options)
        end
      end
    end
  end
end
