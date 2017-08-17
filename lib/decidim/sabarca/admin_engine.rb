# frozen_string_literal: true
module Decidim
  module Sabarca
    # This is the engine that runs on the public interface of `Sabarca`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Sabarca::Admin

      paths["db/migrate"] = nil

      routes do
        # Add admin engine routes here
        # resources :sabarca do
        #   collection do
        #     resources :exports, only: [:create]
        #   end
        # end
        # root to: "sabarca#index"
      end

      initializer "decidim_sabarca.inject_abilities_to_user" do |_app|
        Decidim.configure do |config|
          config.admin_abilities += ["Decidim::Sabarca::Abilities::AdminUser"]
          config.admin_abilities += ["Decidim::Sabarca::Abilities::ProcessAdminUser"]
        end
      end

      def load_seed
        nil
      end
    end
  end
end
