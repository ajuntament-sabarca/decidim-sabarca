# frozen_string_literal: true

module Decidim
  module Sabarca
    # This controller is the abstract class from which all other controllers of
    # this engine inherit.
    #
    # Note that it inherits from `Decidim::Features::BaseController`, which
    # override its layout and provide all kinds of useful methods.
    class ScopesController < Decidim::ApplicationController

      skip_authorization_check

      helper_method :participatory_processes_organization, :organization_scopes, :user_groups, :collection,
                    :participatory_processes, :filter, :decidim_scope_id

      def index
      end

      def show
        @scope = Decidim::Scope.find_by(decidim_organization_id: current_organization.id, id: params[:id])
      end

      private

      def user_groups
        @user_groups ||= Decidim::UserGroup.where(decidim_organization_id: current_organization.id, scope_id: params[:id]).verified
      end

      def participatory_processes_organization
        @partcipatory_processes ||=
        Decidim::ParticipatoryProcess.where(decidim_organization_id: current_organization.id).where(decidim_scope_id: params[:id])
      end

      def organization_scopes
        @scopes ||= Decidim::Scope.where(decidim_organization_id: current_organization.id)
      end

      def collection
        @collection ||= participatory_processes
        # @collection ||= (participatory_processes.to_a + participatory_process_groups).flatten
      end

      def filtered_participatory_processes(filter = default_filter)
        Decidim::ParticipatoryProcesses::OrganizationScopePrioritizedParticipatoryProcesses.new(current_organization, filter, decidim_scope_id)
      end

      def participatory_processes
        @participatory_processes ||= filtered_participatory_processes(filter)
      end

      # def participatory_process_groups
      #   @process_groups ||= Decidim::ParticipatoryProcesses::OrganizationPrioritizedParticipatoryProcessGroups.new(current_organization, filter)
      # end

      def filter
        @filter = params[:filter] || default_filter
      end

      def default_filter
        "active"
      end

      def decidim_scope_id
        params[:id].to_i
      end
    end
  end
end
