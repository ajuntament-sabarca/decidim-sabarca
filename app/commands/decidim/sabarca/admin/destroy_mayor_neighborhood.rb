# frozen_string_literal: true

module Decidim
  module Sabarca
    module Admin
      class DestroyMayorNeighborhood < Rectify::Command
        def initialize(mayor_neighborhood)
          @mayor_neighborhood = mayor_neighborhood
        end

        # Returns nothing.
        def call
          return broadcast(:invalid) if mayor_neighborhood.nil?

          destroy_mayor_neighborhood
          broadcast(:ok)
        end

        private

        attr_reader :mayor_neighborhood

        def destroy_mayor_neighborhood
          mayor_neighborhood.destroy!
        end
      end
    end
  end
end
