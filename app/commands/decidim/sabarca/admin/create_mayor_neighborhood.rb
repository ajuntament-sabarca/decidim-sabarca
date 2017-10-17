# frozen_string_literal: true

module Decidim
  module Sabarca
    module Admin
      # A command with all the business logic when creating a static scope.
      class CreateMayorNeighborhood < Rectify::Command

        def initialize(form)
          @form = form
        end

        def call
          return broadcast(:invalid) if form.invalid?

          create_mayor_neighborhood
          broadcast(:ok)
        end

        private

        attr_reader :form

        def create_mayor_neighborhood
          MayorNeighborhood.create!(
            title: form.title,
            address: form.address,
            slug: form.slug,
            description: form.description,
            start_time: form.start_time,
            end_time: form.end_time,
            decidim_scope_id: form.decidim_scope_id,
            decidim_organization_id: form.decidim_organization_id,
          )
        end
      end
    end
  end
end
