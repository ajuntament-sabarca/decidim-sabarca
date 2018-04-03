# frozen_string_literal: true

# http://edgeapi.rubyonrails.org/classes/Rails/Engine.html
module Decidim
  module Sabarca
    # This is the engine that runs on the public interface of `decidim-sabarca`.
    class Engine < ::Rails::Engine
      require "acts_as_list"

      isolate_namespace Decidim::Sabarca
      engine_name "decidim_sabarca"

      routes do
        # Add engine routes here
        get "transparency", to: "pages#transparency", as: :transparency
        get "city_close_up", to: "pages#city_close_up", as: :city_close_up

        scope :city_close_up, as: :city_close_up do
          resources :processes, only: [:index], controller: "city_close_up_processes" do
            get "/scopes/:id", action: :show, on: :collection, as: :scope
          end
          resources :user_groups, only: [:index], controller: "city_close_up_user_groups" do
            get "/scopes/:id", action: :show, on: :collection, as: :scope
          end
          resources :mayor_neighborhoods, only: [:index], controller: "city_close_up_mayor_neighborhoods" do
            get "/scopes/:id", action: :show, on: :collection, as: :scope
            get "/scopes/:scope_id/mayor_neighborhoods/:slug", to: "mayor_neighborhoods#show", on: :collection, as: :mayor_neighborhood
          end
        end

        namespace :admin do
          resources :mayor_neighborhoods, except: [:show]
          resources :transparency_items, except: [:show]
        end
      end
      initializer "decidim.action_controller" do |_app|
        ActiveSupport.on_load :action_controller do
          helper Decidim::Sabarca::LayoutHelper if respond_to?(:helper)
        end
      end

      initializer "decidim_sabarca.assets" do |app|
        app.config.assets.precompile += %w(decidim_sabarca_manifest.js pages.js scopes-geojson.js)
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

          menu.item I18n.t("menu.city_close_up", scope: "decidim.sabarca"),
                    decidim_sabarca.city_close_up_path,
                    position: 4,
                    active: :inclusive
        end
      end

      initializer "decidim_admin.menu" do
        Decidim.menu :admin_menu do |menu|
          menu.item I18n.t("menu.mayor_in_the_neighborhood", scope: "decidim.sabarca.admin"),
                    decidim_sabarca.admin_mayor_neighborhoods_path,
                    icon_name: "meetings",
                    position: 1,
                    active: :inclusive,
                    if: can?(:index, Decidim::Sabarca::MayorNeighborhood)

          menu.item I18n.t("menu.transparency_items", scope: "decidim.sabarca.admin"),
                    decidim_sabarca.admin_transparency_items_path,
                    icon_name: "external-link",
                    position: 1,
                    active: :inclusive,
                    if: can?(:index, Decidim::Sabarca::TransparencyItem)
        end
      end
    end

    def self.seed!
      # Faker needs to have the `:en` locale in order to work properly, so we
      # must enforce it during the seeds.
      original_locale = I18n.available_locales
      I18n.available_locales = original_locale + [:en] unless original_locale.include?(:en)

      Rails.application.railties.to_a.uniq.each do |railtie|
        next unless railtie.respond_to?(:load_seed) && railtie.class.name.include?("Decidim::Sabarca")

        railtie.load_seed
      end

      I18n.available_locales = original_locale
    end
  end
end
