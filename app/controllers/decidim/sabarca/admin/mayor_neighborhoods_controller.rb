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
          @form = form(MayorNeighborhoodForm).instance
        end
        def create
        end
        def edit
        end
        def update
        end
        def destroy
        end

      end
    end
  end
end
