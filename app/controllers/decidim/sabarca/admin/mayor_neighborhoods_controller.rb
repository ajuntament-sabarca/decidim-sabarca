# frozen_string_literal: true
module Decidim
  module Sabarca
    module Admin
      # This controller is the abstract class from which all other controllers of
      # this engine inherit.
      #
      # Note that it inherits from `Decidim::Admin::Features::BaseController`, which
      # override its layout and provide all kinds of useful methods.
      class MayorNeighborhoodsController < Decidim::Admin::ApplicationController
        layout "decidim/sabarca/admin/mayor_neighborhoods"
        skip_authorization_check
      
        def index

        end
        def show
        end
        def new
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
