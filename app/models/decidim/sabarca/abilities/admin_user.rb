# frozen_string_literal: true

module Decidim
  module Sabarca
    module Abilities
      # Defines the abilities related to sabarca for a logged in admin user.
      # Intended to be used with `cancancan`.
      class AdminUser
        include CanCan::Ability
        attr_reader :user, :context

        def initialize(user, context)
          # return unless user && user.role?(:admin)
          return unless user && user.admin?

          @user = user
          @context = context

          # can :manage, SomeResource
          can :manage, Decidim::Sabarca::MayorNeighborhood
          can :manage, Decidim::Sabarca::TransparencyItem
        end

        private

        def current_settings
          context.fetch(:current_settings, nil)
        end

        def component_settings
          context.fetch(:component_settings, nil)
        end
      end
    end
  end
end
