# frozen_string_literal: true

require "decidim/core"
require "decidim/system"
require "decidim/admin"
require "decidim/api"

require "decidim/verifications"

require "decidim/participatory_processes"

require "decidim/pages"
require "decidim/comments"
require "decidim/meetings"
require "decidim/proposals"
require "decidim/budgets"
require "decidim/accountability"

require "foundation-rails"
require "foundation_rails_helper"

require "decidim/sabarca/admin"
require "decidim/sabarca/engine"
require "decidim/sabarca/admin_engine"
require "decidim/sabarca/component"

module Decidim
  # This namespace holds the logic of the `Sabarca` component. This component
  # allows users to create sabarca in a participatory process.
  module Sabarca
  end
end
