# frozen_string_literal: true

module Decidim
  module Sabarca
    module Admin
    # A form object to create or update scopes.
      class TransparencyItemForm < Decidim::Form
        include Decidim::TranslatableAttributes

        translatable_attribute :text, String
        translatable_attribute :url, String

        attribute :position, Integer
        
        attribute :decidim_organization_id, Integer

        validates :text, :url, translatable_presence: true

      end
    end
  end
end
