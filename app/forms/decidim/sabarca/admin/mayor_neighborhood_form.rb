# frozen_string_literal: true

module Decidim
  module Sabarca
    module Admin
    # A form object to create or update scopes.
      class MayorNeighborhoodForm < Form
        include TranslatableAttributes

        translatable_attribute :title, String
        translatable_attribute :description, String
        translatable_attribute :location, String

        attribute :slug, String
        attribute :address, String
        attribute :latitude, Float
        attribute :longitude, Float
        attribute :start_time, Decidim::Attributes::TimeWithZone
        attribute :end_time, Decidim::Attributes::TimeWithZone
        attribute :decidim_scope_id, Integer
        attribute :decidim_organization_id, Integer


        # validates :title, translatable_presence: true
        # validates :description, translatable_presence: true
        # validates :location, translatable_presence: true
        # validates :slug, presence: true, format: { with: Decidim::ParticipatoryProcess.slug_format }
        # validates :address, presence: true
        # validates :address, geocoding: true, if: -> { Decidim.geocoder.present? }
        # validates :start_time, presence: true, date: { before: :end_time }
        # validates :end_time, presence: true, date: { after: :start_time }
        #
        # validates :scope, presence: true, if: ->(form) { form.decidim_scope_id.present? }

        # validate :slug_uniqueness

        private

        # def slug_uniqueness
        #   return unless OrganizationAssemblies.new(current_organization).query.where(slug: slug).where.not(id: context[:assembly_id]).any?
        #
        #   errors.add(:slug, :taken)
        # end

      end
    end
  end
end
