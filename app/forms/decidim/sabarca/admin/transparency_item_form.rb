# frozen_string_literal: true

require 'uri'
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

        validate :valid_url

        def valid_url
          current_organization.available_locales.each do |locale|
            url = self.try("url_#{locale}")
            unless uri?(url)
              errors.add(:url, :invalid)
            end
          end
        end

        def uri?(string)
          uri = URI.parse(string)
          %w( http https ).include?(uri.scheme)
        rescue URI::BadURIError
          false
        rescue URI::InvalidURIError
          false
        end

      end
    end
  end
end
