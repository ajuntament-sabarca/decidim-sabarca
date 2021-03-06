# frozen_string_literal: true

module Decidim
  module ParticipatoryProcesses
    # This query class filters public processes given an organization and a
    # filter in a meaningful prioritized order.
    class OrganizationScopePrioritizedParticipatoryProcesses < Rectify::Query
      def initialize(organization, decidim_scope_id, filter = "active")
        @organization = organization
        @filter = filter
        @decidim_scope_id = decidim_scope_id
      end

      def query
        Rectify::Query.merge(
          OrganizationPublishedParticipatoryProcesses.new(@organization),
          PrioritizedScopeParticipatoryProcesses.new(@decidim_scope_id),
          FilteredScopeParticipatoryProcesses.new(@decidim_scope_id, @filter)
        ).query
      end
    end
  end
end
