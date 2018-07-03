# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "decidim/sabarca/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  # Decidim.add_default_gemspec_properties(s)
  DECIDIM_VERSION = "0.10.1"

  s.name = "decidim-sabarca"
  s.version = Decidim::Sabarca::VERSION
  s.authors = ["Agustí B.R.", "Isaac Massot"]
  s.email = ["agusti.br@coditramuntana.com", "isaac.mg@coditramuntana.com"]
  s.homepage = "https://github.com/CodiTramuntana/"
  s.summary = "A component for decidim's participatory processes."
  s.description = "Customization for Sant Andreu de la Barca"
  s.license = "AGPLv3"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE-AGPLv3.txt", "Rakefile", "README.md"]

  s.add_dependency "acts_as_list", "0.9.9"
  s.add_dependency "decidim-accountability", DECIDIM_VERSION
  s.add_dependency "decidim-admin", DECIDIM_VERSION
  s.add_dependency "decidim-api", DECIDIM_VERSION
  s.add_dependency "decidim-budgets", DECIDIM_VERSION
  s.add_dependency "decidim-comments", DECIDIM_VERSION
  s.add_dependency "decidim-core", DECIDIM_VERSION
  s.add_dependency "decidim-meetings", DECIDIM_VERSION
  s.add_dependency "decidim-pages", DECIDIM_VERSION
  s.add_dependency "decidim-participatory_processes", DECIDIM_VERSION
  s.add_dependency "decidim-proposals", DECIDIM_VERSION
  s.add_dependency "decidim-system", DECIDIM_VERSION
  s.add_dependency "decidim-verifications", DECIDIM_VERSION
  s.add_dependency "foundation-rails", "6.4.1.3"
  s.add_dependency "foundation_rails_helper", "3.0.0"
  s.add_development_dependency "decidim-dev", DECIDIM_VERSION
end
