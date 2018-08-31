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
    end
  end
end
