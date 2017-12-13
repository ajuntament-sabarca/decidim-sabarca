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
          user_group.slice(:latitude, :longitude, :address).merge(title: user_group.name,
                                                                icon: icon("proposals", width: 40, height: 70, remove_icon_class: true),
                                                                email: user_group.users.first.email,
                                                                address: user_group.address,
                                                                location: "",
                                                                phone: user_group.phone,
                                                                type: UserGroup.model_name.human.parameterize,
                                                              )
        end
      end

      def mayor_neighborhoods_data_for_map(geocoded_mayor_neighborhoods)
        geocoded_mayor_neighborhoods.map do |mayor_neighborhood|
          mayor_neighborhood.slice(:latitude, :longitude, :address).merge(title: translated_attribute(mayor_neighborhood.title),
                                                                          description: translated_attribute(mayor_neighborhood.description),
                                                                          startTimeDay: l(mayor_neighborhood.start_time, format: "%d"),
                                                                          startTimeMonth: l(mayor_neighborhood.start_time, format: "%B"),
                                                                          startTimeYear: l(mayor_neighborhood.start_time, format: "%Y"),
                                                                          startTime: "#{mayor_neighborhood.start_time.strftime("%H:%M")} - #{mayor_neighborhood.end_time.strftime("%H:%M")}",
                                                                          icon: icon("meetings", width: 40, height: 70, remove_icon_class: true),
                                                                          location: translated_attribute(mayor_neighborhood.location),
                                                                          address: mayor_neighborhood.address,
                                                                          # link: decidim_sabarca.city_close_up_mayor_neighborhood_path(city_close_up_id: current_scope.id, slug: mayor_neighborhood.slug),
                                                                          type: MayorNeighborhood.model_name.human.parameterize,
                                                                        )
        end
      end

      def mayor_neighborhood_description(mayor_neighborhood, max_length = 120)
        link = decidim_sabarca.mayor_neighborhood_city_close_up_mayor_neighborhoods_path(mayor_neighborhood.decidim_scope_id, mayor_neighborhood.slug)
        description = translated_attribute(mayor_neighborhood.description)
        tail = "... #{link_to(t("read_more", scope: "decidim.sabarca.mayor_neighborhoods"), link)}".html_safe
        CGI.unescapeHTML html_truncate(description, max_length: max_length, tail: tail)
      end

    end
  end
end
