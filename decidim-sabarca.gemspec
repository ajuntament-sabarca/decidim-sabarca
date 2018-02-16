$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "decidim/sabarca/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  # Decidim.add_default_gemspec_properties(s)

  s.name        = "decidim-sabarca"
  s.version     = Decidim::Sabarca::VERSION
  s.authors     = ["Agustí B.R.", "Isaac Massot"]
  s.email       = ["agusti.br@coditramuntana.com", "isaac.mg@coditramuntana.com"]
  s.homepage    = "https://github.com/CodiTramuntana/"
  s.summary     = "A component for decidim's participatory processes."
  s.description = "Customization for Sant Andreu de la Barca"
  s.license     = "AGPLv3"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE-AGPLv3.txt","Rakefile", "README.md"]

  s.add_dependency "decidim-core", "0.9.2"
  s.add_dependency "acts_as_list", "0.9.9"
  # s.add_development_dependency "decidim-dev", "0.5.0"
end
