module Decidim
  module Sabarca
    module PagesHelper
      def map_for_scopes
        return if Decidim.geocoder.blank?

        map_html_options = {
          class: "google-map",
          id: "map",
          "data-here-app-id" => Decidim.geocoder[:here_app_id],
          "data-here-app-code" => Decidim.geocoder[:here_app_code]
        }
        content_tag :div, class: "row column" do
          content_tag(:div, "", map_html_options)
        end
      end
    end
  end
end
