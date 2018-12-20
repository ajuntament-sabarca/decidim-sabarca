# frozen_string_literal: true

module Decidim
  module Sabarca
    # Extends Decidim::RegistrationForm to add custom
    # Sabarca attributes and validations for `user_group`
    class RegistrationForm < Decidim::RegistrationForm
      attribute :user_group_url, String
      attribute :user_group_scope_id, Integer
      attribute :user_group_address, String

      validate :valid_url, if: :user_group?
      validates :user_group_scope_id, presence: true, if: :user_group?
      validates :user_group_address, presence: true, if: :user_group?

      def valid_url
        errors.add(:user_group_url, :invalid) unless uri?(user_group_url)
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
