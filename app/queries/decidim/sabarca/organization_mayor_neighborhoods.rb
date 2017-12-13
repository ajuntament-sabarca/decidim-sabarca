# frozen_string_literal: true

module Decidim
  module Sabarca
    # This query class filters public processes given an organization and a
    # filter in a meaningful prioritized order.
    class OrganizationMayorNeighborhoods < Rectify::Query
      def initialize(organization, filter_mayor_neighborhood = "upcoming")
        @organization = organization
        @filter_mayor_neighborhood = filter_mayor_neighborhood
      end

      def query
        Rectify::Query.merge(
          FilteredMayorNeighborhoods.new(@organization, @filter_mayor_neighborhood)
        ).query
      end
    end
  end
end
