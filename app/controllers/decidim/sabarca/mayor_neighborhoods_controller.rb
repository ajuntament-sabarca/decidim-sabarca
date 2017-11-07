# frozen_string_literal: true

module Decidim
  module Sabarca
    # This controller is the abstract class from which all other controllers of
    # this engine inherit.
    #
    # Note that it inherits from `Decidim::Features::BaseController`, which
    # override its layout and provide all kinds of useful methods.
    class MayorNeighborhoodsController < Decidim::ApplicationController
      skip_authorization_check

      helper_method :mayor_neighborhood

      def show

      end

      def mayor_neighborhood
        Decidim::Sabarca::MayorNeighborhood.where(decidim_organization_id: current_organization.id, decidim_scope_id: params[:city_close_up_id], slug: params[:id]).first
      end

    end
  end
end
