# frozen_string_literal: true

module Decidim
  module Sabarca
    module Abilities
      # Defines the abilities related to sabarca for a logged in user.
      # Intended to be used with `cancancan`.
      class CurrentUser
        include CanCan::Ability

        attr_reader :user, :context

        def initialize(user, context)
          return unless user

          @user = user
          @context = context

          # can :manage, SomeResource if authorized?(:some_action)
        end

        private

        def authorized?(action)
          return unless component

          ActionAuthorizer.new(user, component, action).authorize.ok?
        end

        def current_settings
          context.fetch(:current_settings, nil)
        end

        def component_settings
          context.fetch(:component_settings, nil)
        end

        def component
          component = context.fetch(:current_component, nil)
          return nil unless component && component.manifest.name == :sabarca

          component
        end
      end
    end
  end
end
