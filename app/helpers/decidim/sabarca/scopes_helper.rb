module Decidim
  module Sabarca
    module ScopesHelper

      def map_for_scopes
        return if Decidim.geocoder.blank?

        map_html_options = {
          class: "google-map",
          id: "map",
          "data-markers-data" => "[]",
          "data-here-app-id" => Decidim.geocoder[:here_app_id],
          "data-here-app-code" => Decidim.geocoder[:here_app_code]
        }
        content_tag :div, class: "row column" do
          content_tag(:div, "", map_html_options)
        end
      end

      def dynamic_map_for(markers_data)
        return if Decidim.geocoder.blank?

        map_html_options = {
          class: "google-map",
          id: "map",
          "data-markers-data" => markers_data.to_json,
          "data-here-app-id" => Decidim.geocoder[:here_app_id],
          "data-here-app-code" => Decidim.geocoder[:here_app_code]
        }
        content = capture { yield }
        content_tag :div, class: "row column" do
          content_tag(:div, "", map_html_options) + content
        end
      end

      def user_groups_data_for_map(geocoded_user_groups)
        geocoded_user_groups.map do |user_group|
          user_group.slice(:latitude, :longitude, :address).merge(name: user_group.name,
                                                                icon: icon("proposals", width: 40, height: 70, remove_icon_class: true),
                                                                email: user_group.users.first.email,
                                                                phone: user_group.phone,
                                                              )
        end
      end

      def mayor_neighborhoods_data_for_map(geocoded_mayor_neighborhoods)
        geocoded_mayor_neighborhoods.map do |mayor_neighborhood|
          mayor_neighborhood.slice(:latitude, :longitude, :address).merge(name: translated_attribute(mayor_neighborhood.title),
                                                                icon: icon("proposals", width: 40, height: 70, remove_icon_class: true),
                                                              )
        end
      end

      def mayor_neighborhood_description(mayor_neighborhood, max_length = 120)
        link = decidim_sabarca.city_close_up_mayor_neighborhood_path(@scope, mayor_neighborhood.slug)
        description = translated_attribute(mayor_neighborhood.description)
        tail = "... #{link_to(t("read_more", scope: "decidim.sabarca.mayor_neighborhoods"), link)}".html_safe
        CGI.unescapeHTML html_truncate(description, max_length: max_length, tail: tail)
      end

    end
  end
end
