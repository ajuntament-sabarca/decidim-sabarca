# frozen_string_literal: true

module Decidim
  module Sabarca
    module Admin
      class DestroyTransparencyItem < Rectify::Command
        def initialize(transparency_item)
          @transparency_item = transparency_item
        end

        # Returns nothing.
        def call
          return broadcast(:invalid) if transparency_item.nil?

          destroy_transparency_item
          broadcast(:ok)
        end

        private

        attr_reader :transparency_item

        def destroy_transparency_item
          transparency_item.destroy!
        end

      end
    end
  end
end
