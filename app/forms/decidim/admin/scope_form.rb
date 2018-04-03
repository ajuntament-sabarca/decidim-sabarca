# frozen_string_literal: true

module Decidim
  module Admin
    # A form object to create or update scopes.
    class ScopeForm < Form
      include TranslatableAttributes

      translatable_attribute :name, String
      attribute :organization, Decidim::Organization
      attribute :code, String
      attribute :parent_id, Integer
      attribute :scope_type_id, Integer

      mimic :scope

      validates :name, translatable_presence: true
      validates :organization, :code, presence: true
      validate :code

      alias organization current_organization

      def scope_type
        Decidim::ScopeType.find_by(id: scope_type_id) if scope_type_id
      end
    end
  end
end
