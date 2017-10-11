# frozen_string_literal: true

module Decidim
  module Sabarca
    module Admin
    # A form object to create or update scopes.
      class MayorNeighborhoodForm < Form
        include Decidim::TranslatableAttributes

        translatable_attribute :title, String
        translatable_attribute :description, String
        translatable_attribute :location, String
        translatable_attribute :description, String
        # translatable_attribute :location_hints, String
        attribute :address, String
        attribute :latitude, Float
        attribute :longitude, Float
        attribute :start_time, Decidim::Attributes::TimeWithZone
        attribute :end_time, Decidim::Attributes::TimeWithZone
        attribute :decidim_scope_id, Integer
        # attribute :decidim_category_id, Integer

        validates :title, translatable_presence: true
        validates :description, translatable_presence: true
        validates :location, translatable_presence: true
        validates :address, presence: true
        validates :address, geocoding: true, if: -> { Decidim.geocoder.present? }
        validates :start_time, presence: true, date: { before: :end_time }
        validates :end_time, presence: true, date: { after: :start_time }

        # validates :current_feature, presence: true
        validates :scope, presence: true, if: ->(form) { form.decidim_scope_id.present? }
        validates :category, presence: true, if: ->(form) { form.decidim_category_id.present? }

        # mimic :scope

        # validates :title, translatable_presence: true
        # validates :organization, :code, presence: true
        # validate :code
        #
        # alias organization current_organization
        #
        # def scope_type
        #   Decidim::ScopeType.find_by(id: scope_type_id) if scope_type_id
        # end
        #
        # private

        # def code_uniqueness
        #   return unless organization && organization.scopes.where(code: code).where.not(id: id).any?
        #
        #   errors.add(:code, :taken)
        # end
      end
    end
  end
end
