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

      helper_method :participatory_processes_organization, :organization_scopes

      def index
      end

      def show
        @scope = Decidim::Scope.find_by(decidim_organization_id: current_organization.id, id: params[:id])
        @user_groups = Decidim::UserGroup.where(decidim_organization_id: current_organization.id, scope_id: params[:id]).verified
      end

      def participatory_processes_organization
        @partcipatory_processes ||=
        Decidim::ParticipatoryProcess.where(decidim_organization_id: current_organization.id).where(decidim_scope_id: params[:id])
      end

      def organization_scopes
        @scopes ||= Decidim::Scope.where(decidim_organization_id: current_organization.id)
      end


    end
  end
end
