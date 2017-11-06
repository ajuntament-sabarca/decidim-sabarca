# frozen_string_literal: true

module Decidim
  module Sabarca
    module Admin
      # A command with all the business logic when creating a static scope.
      class UpdateTransparencyItem < Rectify::Command

        attr_reader :transparency_item

        def initialize(transparency_item, form)
          @transparency_item = transparency_item
          @form = form
        end

        # Returns nothing.
        def call
          return broadcast(:invalid) if form.invalid?

          update_transparency_item
          broadcast(:ok)
        end

        private

        attr_reader :form

        def update_transparency_item
          transparency_item.update_attributes!(attributes)
        end

        def attributes
          {
            text: form.text,
            url: form.url,
            position: form.position,
            decidim_organization_id: form.decidim_organization_id,
          }
        end
      end
    end
  end
end
