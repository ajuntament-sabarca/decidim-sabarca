# frozen_string_literal: true

require "decidim/core/test/factories"

FactoryGirl.define do
  factory :sabarca_component, parent: :component do
    name { Decidim::Components::Namer.new(participatory_process.organization.available_locales, :sabarca).i18n_name }
    manifest_name :sabarca
    participatory_process { create(:participatory_process, :with_steps) }
  end

  # Add engine factories here
end
