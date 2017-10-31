# frozen_string_literal: true

module Decidim
  module Sabarca
    module Admin
      # A command with all the business logic when creating a static scope.
      class UpdateMayorNeighborhood < Rectify::Command

        attr_reader :mayor_neighborhood

        def initialize(mayor_neighborhood, form)
          @mayor_neighborhood = mayor_neighborhood
          @form = form
        end

        # Returns nothing.
        def call
          return broadcast(:invalid) if form.invalid?

          update_mayor_neighborhood
          broadcast(:ok)
        end

        private

        attr_reader :form

        def update_mayor_neighborhood
          mayor_neighborhood.update_attributes!(attributes)
        end

        def attributes
          {
            title: form.title,
            address: form.address,
            slug: form.slug,
            description: form.description,
            councilors: form.councilors,
            topics: form.topics,
            start_time: form.start_time,
            end_time: form.end_time,
            decidim_scope_id: form.decidim_scope_id,
            decidim_organization_id: form.decidim_organization_id,
          }
        end
      end
    end
  end
end
