# frozen_string_literal: true

module Decidim
  module Sabarca
    # This controller is the abstract class from which all other controllers of
    # this engine inherit.
    #
    # Note that it inherits from `Decidim::Components::BaseController`, which
    # override its layout and provide all kinds of useful methods.
    class CityCloseUpUserGroupsController < Decidim::ApplicationController
      helper Decidim::Sabarca::ScopesHelper

      helper_method :organization_scopes, :user_groups, :current_scope

      def index; end

      def show
        @user_groups_scoped = user_groups.where(scope_id: current_scope)
      end

      private

      def user_groups
        @user_groups ||= Decidim::UserGroup.where(decidim_organization_id: current_organization.id).verified
      end

      def organization_scopes
        @scopes ||= Decidim::Scope.where(decidim_organization_id: current_organization.id)
      end

      def current_scope
        @scope ||= organization_scopes.find_by(decidim_organization_id: current_organization.id, id: params[:id])
      end
    end
  end
end
