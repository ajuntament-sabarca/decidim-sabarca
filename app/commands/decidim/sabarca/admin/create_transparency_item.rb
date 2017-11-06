# frozen_string_literal: true

module Decidim
  module Sabarca
    module Admin
      # A command with all the business logic when creating a static scope.
      class CreateTransparencyItem < Rectify::Command

        def initialize(form)
          @form = form
        end

        def call
          return broadcast(:invalid) if form.invalid?

          create_transparency_item
          broadcast(:ok)
        end

        private

        attr_reader :form

        def create_transparency_item
          TransparencyItem.create!(
            text: form.text,
            url: form.url,
            position: form.position,
            decidim_organization_id: form.decidim_organization_id,
          )
        end
      end
    end
  end
end
