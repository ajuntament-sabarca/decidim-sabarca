# frozen_string_literal: true

module Decidim
  module Sabarca
    # This controller is the abstract class from which all other controllers of
    # this engine inherit.
    #
    # Note that it inherits from `Decidim::Features::BaseController`, which
    # override its layout and provide all kinds of useful methods.
    class CityCloseUpMayorNeighborhoodsController < Decidim::ApplicationController
      helper Decidim::Sabarca::ScopesHelper
      skip_authorization_check

      helper_method :organization_scopes, :decidim_scope_id, :current_scope,
                    :collection_mayor_neighborhoods, :collection_scoped_mayor_neighborhoods,
                    :mayor_neighborhoods, :scoped_mayor_neighborhoods,
                    :filter_mayor_neighborhood

      def index
      end

      def show
      end

      private

      def organization_scopes
        @scopes ||= Decidim::Scope.where(decidim_organization_id: current_organization.id)
      end

      def decidim_scope_id
        params[:id].to_i
      end

      def current_scope
        @scope ||= organization_scopes.find_by(decidim_organization_id: current_organization.id, id: params[:id])
      end

      def collection_mayor_neighborhoods
        @collection_mayor_neighborhood ||= mayor_neighborhoods
      end

      def collection_scoped_mayor_neighborhoods
        @collection_mayor_neighborhood ||= scoped_mayor_neighborhoods
      end

      def filtered_mayor_neighborhoods(filter_mayor_neighborhood = default_filter_mayor_neighborhood)
        Decidim::Sabarca::OrganizationMayorNeighborhoods.new(current_organization, filter_mayor_neighborhood)
      end

      def filtered_scoped_mayor_neighborhoods(filter_mayor_neighborhood = default_filter_mayor_neighborhood)
        Decidim::Sabarca::OrganizationScopeMayorNeighborhoods.new(current_organization, filter_mayor_neighborhood, decidim_scope_id)
      end

      def mayor_neighborhoods
        @mayor_neighborhoods ||= filtered_mayor_neighborhoods(filter_mayor_neighborhood)
      end

      def scoped_mayor_neighborhoods
        @mayor_neighborhoods ||= filtered_scoped_mayor_neighborhoods(filter_mayor_neighborhood)
      end

      def filter_mayor_neighborhood
        @filter_mayor_neighborhood = params[:filter_mayor_neighborhood] || default_filter_mayor_neighborhood
      end

      def default_filter_mayor_neighborhood
        "active"
      end

    end
  end
end
