module Decidim
  module Sabarca
    # Abstract class from which all models in this engine inherit.
    class TransparencyItem < Decidim::ApplicationRecord
      belongs_to :organization, foreign_key: "decidim_organization_id", class_name: "Decidim::Organization"

    end
  end
end
