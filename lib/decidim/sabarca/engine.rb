# frozen_string_literal: true

module Decidim
  module Sabarca
    # This is the engine that runs on the public interface of `decidim-sabarca`.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Sabarca

      routes do
        # Add engine routes here
        # resources :sabarca
        # root to: "sabarca#index"
      end

      initializer "decidim_sabarca.assets" do |app|
        app.config.assets.precompile += %w(decidim_sabarca_manifest.js decidim_sabarca_manifest.css)
      end

      initializer "decidim_sabarca.inject_abilities_to_user" do |_app|
        Decidim.configure do |config|
          config.abilities += ["Decidim::Sabarca::Abilities::CurrentUser"]
        end
      end
    end
  end
end
