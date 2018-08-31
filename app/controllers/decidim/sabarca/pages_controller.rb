# frozen_string_literal: true

module Decidim
  module Sabarca
    class PagesController < Decidim::PagesController
      def transparency
        @transparency_items = Decidim::Sabarca::TransparencyItem.where(organization: current_organization)
      end

      def city_close_up; end
    end
  end
end
