# frozen_string_literal: true

module Decidim
  module Sabarca
    # This controller is the abstract class from which all other controllers of
    # this engine inherit.
    #
    # Note that it inherits from `Decidim::Features::BaseController`, which
    # override its layout and provide all kinds of useful methods.
    class PagesController < Decidim::PagesController
      def transparency
      end
      def city_close_up_index
      end
      def city_close_up_show
      end
    end
  end
end
