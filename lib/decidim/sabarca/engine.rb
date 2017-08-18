# frozen_string_literal: true

# http://edgeapi.rubyonrails.org/classes/Rails/Engine.html
module Decidim
  module Sabarca
    # This is the engine that runs on the public interface of `decidim-sabarca`.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Sabarca
      engine_name "decidim_sabarca"

      routes do
        # Add engine routes here
        # resources :sabarca
        # root to: "sabarca#index"
        get 'transparency', to: "pages#show", as: :transparency
        get 'city_close_up', to: "pages#show", as: :city_close_up
        get 'city_close_up/:scope_id', to: "pages#show", as: :city_close_up_scope
      end

      initializer "decidim_sabarca.assets" do |app|
        app.config.assets.precompile += %w(decidim_sabarca_manifest.js decidim_sabarca_manifest.css)
      end

      initializer "decidim_sabarca.i18n_exceptions" do
        ActionView::Base.raise_on_missing_translations = false # true unless Rails.env.production?
      end

      initializer "decidim_sabarca.inject_abilities_to_user" do |_app|
        Decidim.configure do |config|
          config.abilities += ["Decidim::Sabarca::Abilities::CurrentUser"]
        end
      end

      initializer "decidim.menu" do
        Decidim.menu :menu do |menu|
          menu.item I18n.t("menu.transparency", scope: "decidim.sabarca"),
            decidim_sabarca.transparency_path,
            position: 3,
            active: :inclusive
        end
        Decidim.menu :menu do |menu|
          menu.item I18n.t("menu.city_close_up", scope: "decidim.sabarca"),
            decidim_sabarca.city_close_up_path,
            position: 4,
            active: :inclusive
        end
      end

    end

    def self.seed!
      # Faker needs to have the `:en` locale in order to work properly, so we
      # must enforce it during the seeds.
      original_locale = I18n.available_locales
      I18n.available_locales = original_locale + [:en] unless original_locale.include?(:en)

      Rails.application.railties.to_a.uniq.each do |railtie|
        next unless railtie.respond_to?(:load_seed) && railtie.class.name.include?("Decidim::")

        railtie.load_seed
      end

      I18n.available_locales = original_locale
    end
  end
end
