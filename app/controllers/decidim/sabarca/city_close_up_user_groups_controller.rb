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

      helper_method :user_groups, :user_groups_scoped, :organization_scopes, :current_scope

      def index; end

      def show; end

      private

      def user_groups
        @user_groups ||= Decidim::UserGroup.where(decidim_organization_id: current_organization.id).verified
      end

      def user_groups_scoped
        @user_groups_scoped ||= user_groups.select { |g| g.scope_id == current_scope.id }
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
