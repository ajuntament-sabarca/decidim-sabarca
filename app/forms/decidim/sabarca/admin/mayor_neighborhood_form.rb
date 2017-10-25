# frozen_string_literal: true

module Decidim
  module Sabarca
    module Admin
    # A form object to create or update scopes.
      class MayorNeighborhoodForm < Decidim::Form
        include Decidim::TranslatableAttributes

        translatable_attribute :title, String
        translatable_attribute :description, String

        attribute :slug, String
        attribute :address, String
        attribute :latitude, Float
        attribute :longitude, Float
        attribute :start_time, Decidim::Attributes::TimeWithZone
        attribute :end_time, Decidim::Attributes::TimeWithZone
        attribute :decidim_scope_id, Integer
        attribute :decidim_organization_id, Integer

        validates :title, :description, translatable_presence: true

        validates :slug, presence: true
        validates :slug, format: { with: /\A[a-z0-9-]+/ }
        validates :address, presence: true
        validates :start_time, presence: true, date: { before: :end_time }
        validates :end_time, presence: true, date: { after: :start_time }

      end
    end
  end
end