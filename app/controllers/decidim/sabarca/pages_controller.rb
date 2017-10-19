# frozen_string_literal: true

module Decidim
  module Sabarca
    # This controller is the abstract class from which all other controllers of
    # this engine inherit.
    #
    # Note that it inherits from `Decidim::Features::BaseController`, which
    # override its layout and provide all kinds of useful methods.
    class PagesController < Decidim::PagesController
      include FilterResource
      include Paginable

      helper Decidim::FiltersHelper

      helper_method :participatory_processes_organization, :organization_scopes, :mayor_neighborhoods, :mayor_neighborhood, :geocoded_mayor_neighborhoods

      def transparency
      end

      def city_close_up_index
      end

      def city_close_up_show
        @scope = Decidim::Scope.find_by(decidim_organization_id: current_organization.id, id: params[:scope_id])
        @user_groups = Decidim::UserGroup.where(decidim_organization_id: current_organization.id, scope_id: params[:scope_id])

        # return unless search.results.empty? && params.dig("filter", "date") != "past"

        # @past_mayor_neighborhoods = search_klass.new(search_params.merge(date: "past"))
        # unless @past_mayor_neighborhoods.results.empty?
        #   params[:filter] ||= {}
        #   params[:filter][:date] = "past"
        #   @forced_past_mayor_neighborhoods = true
        #   @search = @past_mayor_neighborhoods
        # end

      end

      def participatory_processes_organization
        @partcipatory_processes ||=
          Decidim::ParticipatoryProcess.where(decidim_organization_id: current_organization.id).where(decidim_scope_id: params[:scope_id])
      end

      def organization_scopes
        @scopes ||= Decidim::Scope.where(decidim_organization_id: current_organization.id)
      end

      private

      def mayor_neighborhoods
        @mayor_neighborhoods ||= search.results.page(params[:page]).per(12)
      end

      def random_seed
        @random_seed ||= search.random_seed
      end

      def mayor_neighborhood
        @mayor_neighborhood ||= mayor_neighborhoods.find(params[:id])
      end

      def geocoded_mayor_neighborhoods
        @geocoded_mayor_neighborhoods ||= search.results.select(&:geocoded?)
      end


      def search_klass
        MayorNeighborhoodSearch
      end

      def default_filter_params
        {
          date: "upcoming",
          search_text: "",
          # scope_id: "",
          # category_id: ""
        }
      end

      def context_params
        { organization: current_organization}
      end

    end
  end
end
