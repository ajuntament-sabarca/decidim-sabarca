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
        @scope = Decidim::Scope.find_by(decidim_organization_id: current_organization.id, id: params[:scope_id])
      end

      def mayor_neighborhood
        Decidim::Sabarca::MayorNeighborhood.find_by(decidim_organization_id: current_organization.id, decidim_scope_id: params[:scope_id], slug: params[:slug])
      end
    end
  end
end
