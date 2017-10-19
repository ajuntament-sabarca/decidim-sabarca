# frozen_string_literal: true
module Decidim
  module Sabarca
    module Admin
      class MayorNeighborhoodsController < Decidim::Admin::ApplicationController
        layout "decidim/sabarca/admin/mayor_neighborhoods"

        def index
          authorize! :index, Decidim::Sabarca::MayorNeighborhood
          @mayor_neighborhoods ||= collection
        end

        def show
          @mayor_neighborhood = collection.find(params[:id])
          authorize! :read, @mayor_neighborhood
        end

        def new
          authorize! :new, Decidim::Sabarca::MayorNeighborhood
          @form = form(Decidim::Sabarca::Admin::MayorNeighborhoodForm).from_params({})
        end

        def create
          authorize! :create, Decidim::Sabarca::MayorNeighborhood

          @form = form(Decidim::Sabarca::Admin::MayorNeighborhoodForm).from_params(form_params)

          CreateMayorNeighborhood.call(@form) do
            on(:ok) do
              flash[:notice] = I18n.t("mayor_neighborhoods.create.success", scope: "decidim.admin.actions")
              redirect_to decidim_sabarca.admin_mayor_neighborhoods_path
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("mayor_neighborhoods.create.error", scope: "decidim.admin.actions")
              render :new
            end
          end
        end

        def edit
          @mayor_neighborhood = collection.find(params[:id])
          authorize! :edit, @mayor_neighborhood

          @form = form(Decidim::Sabarca::Admin::MayorNeighborhoodForm).from_model(@mayor_neighborhood)
        end

        def update
          @mayor_neighborhood = collection.find(params[:id])
          authorize! :update, @mayor_neighborhood

          @form = form(Decidim::Sabarca::Admin::MayorNeighborhoodForm).from_params(form_params)

          UpdateMayorNeighborhood.call(@mayor_neighborhood, @form) do
            on(:ok) do
              flash[:notice] = I18n.t("mayor_neighborhoods.update.success", scope: "decidim.admin.actions")
              redirect_to decidim_sabarca.admin_mayor_neighborhood_path(@mayor_neighborhood)
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("mayor_neighborhoods.update.error", scope: "decidim.admin.actions")
              render :edit
            end
          end
        end

        def destroy
          @mayor_neighborhood = collection.find(params[:id])
          authorize! :destroy, @mayor_neighborhood

          DestroyMayorNeighborhood.call(@mayor_neighborhood) do
            on(:ok) do
              flash[:notice] = I18n.t("mayor_neighborhoods.destroy.success", scope: "decidim.admin.actions")
            end

            on(:invalid) do
              flash[:alert] = I18n.t("mayor_neighborhoods.destroy.error", scope: "decidim.admin.actions")
            end

            redirect_back(fallback_location: decidim_sabarca.admin_mayor_neighborhoods_path)
          end
        end

        private

        def form_params
          form_params = params.to_unsafe_hash
          form_params["mayor_neighborhood"] ||= {}
          form_params["mayor_neighborhood"]["decidim_organization_id"] = current_organization.id

          return form_params unless mayor_neighborhood

          form_params["mayor_neighborhood"]["slug"] ||= mayor_neighborhood.slug
          form_params
        end

        def mayor_neighborhood
          @mayor_neighborhood ||= collection.find_by(slug: params[:id])
        end

        def collection
          Decidim::Sabarca::MayorNeighborhood.where(decidim_organization_id: current_organization.id)
        end

      end
    end
  end
end
