# frozen_string_literal: true

module Decidim
  module Sabarca
    # This controller is the abstract class from which all other controllers of
    # this engine inherit.
    #
    # Note that it inherits from `Decidim::Components::BaseController`, which
    # override its layout and provide all kinds of useful methods.
    class CityCloseUpProcessesController < Decidim::ApplicationController
      helper Decidim::Sabarca::ScopesHelper

      helper_method :participatory_processes_organization, :organization_scopes, :collection,
                    :participatory_processes, :filter, :decidim_scope_id, :current_scope
      helper_method :process_count_by_filter

      def index; end

      def show; end

      private

      def participatory_processes_organization
        @partcipatory_processes ||=
          Decidim::ParticipatoryProcess.where(decidim_organization_id: current_organization.id).where(decidim_scope_id: params[:id])
      end

      def organization_scopes
        @scopes ||= Decidim::Scope.where(decidim_organization_id: current_organization.id)
      end

      def collection
        @collection ||= participatory_processes
      end

      def filtered_participatory_processes(filter = default_filter)
        Decidim::ParticipatoryProcesses::OrganizationScopePrioritizedParticipatoryProcesses.new(current_organization, decidim_scope_id, filter)
      end

      def participatory_processes
        @participatory_processes ||= filtered_participatory_processes(filter)
      end

      def filter
        @filter = params[:filter] || default_filter
      end

      def default_filter
        "active"
      end

      def decidim_scope_id
        params[:id].to_i
      end

      def current_scope
        @scope ||= organization_scopes.find_by(decidim_organization_id: current_organization.id, id: params[:id])
      end

      def filtered_participatory_process_groups(filter_name = filter)
        Decidim::ParticipatoryProcesses::OrganizationPrioritizedParticipatoryProcessGroups.new(current_organization, filter_name)
      end

      def participatory_process_groups
        @participatory_process_groups ||= filtered_participatory_process_groups(filter)
      end

      def filter
        @filter = params[:filter] || default_filter
      end

      def default_filter
        return "active" if process_count_by_filter["active"].positive?
        return "upcoming" if process_count_by_filter["upcoming"].positive?
        return "past" if process_count_by_filter["past"].positive?
        "active"
      end

      def process_count_by_filter
        return @process_count_by_filter if @process_count_by_filter

        @process_count_by_filter = %w(active upcoming past).inject({}) do |collection_by_filter, filter_name|
          processes = filtered_participatory_processes(filter_name)
          groups = filtered_participatory_process_groups(filter_name)
          collection_by_filter.merge(filter_name.to_s => processes.count + groups.count)
        end
        @process_count_by_filter["all"] = @process_count_by_filter.values.sum
        @process_count_by_filter
      end
    end
  end
end
