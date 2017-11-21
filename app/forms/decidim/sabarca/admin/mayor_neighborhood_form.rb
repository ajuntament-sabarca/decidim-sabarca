# frozen_string_literal: true

module Decidim
  module Sabarca
    module Admin
    # A form object to create or update scopes.
      class MayorNeighborhoodForm < Decidim::Form
        include Decidim::TranslatableAttributes

        translatable_attribute :title, String
        translatable_attribute :description, String
        translatable_attribute :councilors, String
        translatable_attribute :topics, String
        translatable_attribute :location, String

        attribute :slug, String
        attribute :address, String
        attribute :latitude, Float
        attribute :longitude, Float
        attribute :start_time, Decidim::Attributes::TimeWithZone
        attribute :end_time, Decidim::Attributes::TimeWithZone
        attribute :decidim_scope_id, Integer
        attribute :decidim_organization_id, Integer

        validates :title, :description, :location, translatable_presence: true

        validates :slug, presence: true, format: { with: Decidim::ParticipatoryProcess.slug_format }
        validates :address, presence: true
        validates :start_time, presence: true, date: { before: :end_time }
        validates :end_time, presence: true, date: { after: :start_time }
        validates :decidim_scope_id, presence: true

      end
    end
  end
end
