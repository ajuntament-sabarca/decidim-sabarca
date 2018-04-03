# frozen_string_literal: true

module Decidim
  module Sabarca
    # This query class filters public processes given an organization and a
    # filter in a meaningful prioritized order.
    class OrganizationScopeMayorNeighborhoods < Rectify::Query
      def initialize(organization, decidim_scope_id, filter_mayor_neighborhood = "upcoming")
        @organization = organization
        @filter_mayor_neighborhood = filter_mayor_neighborhood
        @decidim_scope_id = decidim_scope_id
      end

      def query
        Rectify::Query.merge(
          FilteredScopeMayorNeighborhoods.new(@organization, @decidim_scope_id, @filter_mayor_neighborhood)
        ).query
      end
    end
  end
end
