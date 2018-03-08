# frozen_string_literal: true

module Decidim
  # View helpers related to the layout.
  module Sabarca
    module LayoutHelper

      ##NOT USED NOW

      def icon_sabarca(name, options = {})
        html_properties = {}

        html_properties["width"] = options[:width]
        html_properties["height"] = options[:height]
        html_properties["aria-label"] = options[:aria_label]
        html_properties["role"] = options[:role]
        html_properties["aria-hidden"] = options[:aria_hidden]

        html_properties["class"] = (["icon--sabarca--#{name}"] + _icon_classes(options)).join(" ")

        content_tag :svg, html_properties do
          content_tag :use, nil, "xlink:href" => "#{asset_path("decidim/sabarca/icons_sabarca.svg")}#icon-sabarca-#{name}"
        end
      end

      # Outputs a SVG icon from an external file. It apparently renders an image
      # tag, but then a JS script kicks in and replaces it with an inlined SVG
      # version.
      #
      # path    - The asset's path
      #
      # Returns an <img /> tag with the SVG icon.
      def external_icon(path, options = {})
        classes = _icon_classes(options) + ["external-icon"]

        if path.split(".").last == "svg"
          asset = Rails.application.assets_manifest.find_sources(path).first
          asset.gsub("<svg ", "<svg class=\"#{classes.join(" ")}\" ").html_safe
        else
          image_tag(path, class: classes.join(" "), style: "display: none")
        end
      end

      def _icon_classes(options = {})
        classes = options[:remove_icon_class] ? [] : ["icon"]
        classes += [options[:class]]
        classes.compact
      end

      def header_section
        if (controller_name == "pages" and %w(show index).exclude? action_name) or
          (controller_name == "participatory_processes" and action_name == "index") or
          (controller_name == "authorizations" and action_name == "new") or
          (%w(mayor_neighborhoods city_close_up_processes city_close_up_user_groups city_close_up_mayor_neighborhoods).include? controller_name)
          case controller_name
          when "participatory_processes"
            @title = t(".processes")
            @subtitle = ""
          when "pages"
            case action_name
            when "transparency"
              @title= t(".transparency")
              @subtitle= t(".subtitle_transparency")
            when "city_close_up"
              @title= t(".city_close_up")
              @subtitle= t(".city_close_up_subtitle")
            end
          when "city_close_up_processes"
            case action_name
            when "index"
              @title= t(".city_close_up_processes")
              @subtitle= t(".city_close_up_processes_subtitle")
            when "show"
              @title= t(".city_close_up_processes") + " - " + translated_attribute(current_scope.name)
              @subtitle= ""
            end
          when "city_close_up_user_groups"
            case action_name
            when "index"
              @title= t(".city_close_up_user_groups")
              @subtitle= t(".city_close_up_user_groups_subtitle")
            when "show"
              @title= t(".city_close_up_user_groups") + " - " + translated_attribute(current_scope.name)
              @subtitle= ""
            end
          when "city_close_up_mayor_neighborhoods"
            case action_name
            when "index"
              @title= t(".city_close_up_mayor_neighborhoods")
              @subtitle= t(".city_close_up_mayor_neighborhoods_subtitle")
            when "show"
              @title= t(".city_close_up_mayor_neighborhoods") + " - " + translated_attribute(current_scope.name)
              @subtitle= ""
            end
          when "scopes"
            case action_name
            when "index"
              @title= t(".city_close_up")
              @subtitle= t(".city_close_up_subtitle")
            when "show"
              @title= translated_attribute(current_scope.name)
              @subtitle= ""
            end
          when "mayor_neighborhoods"
            case action_name
            when "show"
              @title= translated_attribute(mayor_neighborhood.title)
              @subtitle= ""
            end
          when "authorizations"
            authorizer = @authorization.try(:name) || handler.handler_name
            @title= t(".authorize_with", authorizer: t("#{authorizer}.name", scope: "decidim.authorization_handlers"))
            @subtitle= ""
          end
          render "decidim/sabarca/shared/section_header_sabarca", title: @title, subtitle: @subtitle
        end
      end
    end
  end
end
