# frozen_string_literal: true
module Decidim
  module Sabarca
    module Admin
      class MayorNeighborhoodsController < Decidim::Admin::ApplicationController
        layout "decidim/sabarca/admin/mayor_neighborhoods"

        def index
          authorize! :index, Decidim::Sabarca::MayorNeighborhood
          # @scopes = children_scopes.order("name->'#{I18n.locale}' ASC")
        end

        def show
        end

        def new
          authorize! :new, Decidim::Sabarca::MayorNeighborhood
          # @form = form(MayorNeighborhoodForm).instance
          @form = form(Decidim::Sabarca::Admin::MayorNeighborhoodForm).from_params({})
        end

        def create
          authorize! :create, Decidim::Sabarca::MayorNeighborhood

          @form = form(Decidim::Sabarca::Admin::MayorNeighborhoodForm).from_params(form_params)

          CreateMayorNeighborhood.call(@form) do
            on(:ok) do
              flash[:notice] = I18n.t("categories.create.success", scope: "decidim.admin")
              redirect_to decidim_sabarca.admin_mayor_neighborhoods_path
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("categories.create.error", scope: "decidim.admin")
              render :new
            end
          end
        end

        def edit
        end

        def update
        end

        def destroy
        end

        private

        def form_params
          form_params = params.to_unsafe_hash
          form_params["mayor_neighborhood"] ||= {}
          form_params["mayor_neighborhood"]["decidim_organization_id"] = current_organization.id

          return form_params unless mayor_neighborhood
          # raise
          form_params["mayor_neighborhood"]["slug"] ||= mayor_neighborhood.slug
          form_params
        end

        def mayor_neighborhood
          @mayor_neighborhood ||= collection.find_by(slug: params[:id])
        end

        def collection
          Decidim::Sabarca::MayorNeighborhood.where(decidim_organization_id: current_organization.id)
          # current_organization.mayor_neighborhoods
        end

      end
    end
  end
end
