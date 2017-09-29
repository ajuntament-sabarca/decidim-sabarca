# frozen_string_literal: true

module Decidim
  module Sabarca
    # This controller is the abstract class from which all other controllers of
    # this engine inherit.
    #
    # Note that it inherits from `Decidim::Features::BaseController`, which
    # override its layout and provide all kinds of useful methods.
    class PagesController < Decidim::PagesController
      helper_method :participatory_processes_organization, :organization_scopes

      def transparency
      end
      def city_close_up_index
      end
      def city_close_up_show
        #PODER NO CAL#
        @scope = Decidim::Scope.find_by(decidim_organization_id: current_organization.id, id: params[:scope_id])
      end

      def participatory_processes_organization
        @partcipatory_processes ||=
          Decidim::ParticipatoryProcess.where(decidim_organization_id: current_organization.id).where(decidim_scope_id: params[:scope_id])
      end

      def organization_scopes
        @scopes ||= Decidim::Scope.where(decidim_organization_id: current_organization.id)
      end


    end
  end
end
