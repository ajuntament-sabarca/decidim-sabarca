# frozen_string_literal: true

module Decidim
  module Sabarca
    # Abstract class from which all models in this engine inherit.
    class TransparencyItem < Decidim::Sabarca::ApplicationRecord
      acts_as_list scope: :decidim_organization_id

      belongs_to :organization, foreign_key: "decidim_organization_id", class_name: "Decidim::Organization"

      default_scope { order(:position) }
    end
  end
end
