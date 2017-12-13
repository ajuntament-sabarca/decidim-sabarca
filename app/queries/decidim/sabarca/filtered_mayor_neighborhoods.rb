# frozen_string_literal: true

module Decidim
  module Sabarca
    # This query class filters participatory processes given a filter name.
    # It uses the start and end dates to select the correct processes.
    class FilteredMayorNeighborhoods < Rectify::Query
      def initialize(organization, filter_mayor_neighborhood = "active")
        @organization = organization
        @filter_mayor_neighborhood = filter_mayor_neighborhood
      end

      def query

        mayor_neighborhoods = Decidim::Sabarca::MayorNeighborhood.
                    where(decidim_organization_id: @organization).
                    order(start_time: :desc)
        case @filter_mayor_neighborhood
        when "past"
          mayor_neighborhoods.where("decidim_sabarca_mayor_neighborhoods.end_time <= ?", Time.current).order(end_time: :desc)
        when "upcoming"
          mayor_neighborhoods.where("decidim_sabarca_mayor_neighborhoods.start_time > ?", Time.current).order(start_time: :asc)
        else
          mayor_neighborhoods
        end
      end
    end
  end
end
