# frozen_string_literal: true

require "uri"
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
        validate :valid_url, :validate_text_length

        def validate_text_length
          current_organization.available_locales.each do |locale|
            errors.add(:"text_#{locale}", :too_long, count: 150) if try("text_#{locale}").size > 150
          end
        end

        def valid_url
          current_organization.available_locales.each do |locale|
            url = try("url_#{locale}")
            errors.add(:"url_#{locale}", :invalid) unless uri?(url)
          end
        end

        def uri?(string)
          uri = URI.parse(string)
          %w(http https).include?(uri.scheme)
        rescue URI::BadURIError
          false
        rescue URI::InvalidURIError
          false
        end
      end
    end
  end
end
