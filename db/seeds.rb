# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# You can remove the 'faker' gem if you don't want Decidim seeds.
#Decidim.seed!

# frozen_string_literal: true

# You can remove the 'faker' gem if you don't want Decidim seeds.
# Decidim.seed!

puts "seeding from Decidim::Sabarca"

if !Rails.env.production? || ENV["SEED"]
  ## decidim-system seeds
  Decidim::System::Admin.find_or_initialize_by(email: "system@example.org").update!(
    password: "decidim123456",
    password_confirmation: "decidim123456"
  )

  Decidim::Organization.find_each do |organization|
    Decidim::System::CreateDefaultPages.call(organization)
  end
end

## decidim-core seeds

if !Rails.env.production? || ENV["SEED"]
  require "decidim/faker/localized"

  seeds_root = File.join(__dir__, "seeds")

  organization = Decidim::Organization.first || Decidim::Organization.create!(
    name: "Ajuntament St. Andreu de la Barca",
    twitter_handler: "Ajuntamentsab",
    facebook_handler: "ajuntamentsab",
    instagram_handler: "ajuntamentsab",
    youtube_handler: "ajuntamentSabarca",
    github_handler: "ajuntament-sabarca",
    host: ENV["DECIDIM_HOST"] || "localhost",
    welcome_text: {
      "ca": "Volem fomentar la participació",
      "es": "Queremos fomentar la participación"
    },
    description: {
      "ca": "<p>L'Ajuntament de Sant Andreu de la Barca vol fomentar la participació, l'atenció ciutadana i la comunicació amb la ciutadania</p>",
      "es": "<p>El Ayuntamiento de Sant Andreu de la Barca quiere fomentar la participación, la atención ciudadana y la comunicación con la ciudadanía</p>"
    },
    default_locale: Decidim.default_locale,
    available_locales: Decidim.available_locales,
    reference_prefix: "sab",
    official_url: "http://sabarca.cat/",
    homepage_image: File.new(File.join("#{seeds_root}", "homepage_image-ajsab.jpg")),
    logo: File.new(File.join("#{seeds_root}", "logo-header-ajsab.jpg")),
    favicon: File.new(File.join("#{seeds_root}", "favicon-ajsab.jpg")),
    official_img_header: File.new(File.join("#{seeds_root}", "logo-ajsab.jpg")),
    official_img_footer: File.new(File.join("#{seeds_root}", "logo-footer-ajsab.jpg")),
  )
  organization.update!(available_authorizations: ["Decidim::Sabarca::DummyAuthorizationHandler"])

  district_scope = Decidim::ScopeType.create!(
    name: Decidim::Faker::Localized.literal("district_scope"),
    plural: Decidim::Faker::Localized.literal("districts"),
    organization: organization
  )

  district1 = Decidim::Scope.create!(
    name: Decidim::Faker::Localized.literal("El Palau"),
    code: "08740",
    scope_type: district_scope,
    organization: organization
  )

  district2 = Decidim::Scope.create!(
    name: Decidim::Faker::Localized.literal("Santa Teresa"),
    code: "08741",
    scope_type: district_scope,
    organization: organization
  )


  Decidim::User.find_or_initialize_by(email: "admin@example.org").update!(
    name: Faker::Name.name,
    password: "decidim123456",
    password_confirmation: "decidim123456",
    organization: organization,
    confirmed_at: Time.current,
    locale: I18n.default_locale,
    admin: true,
    tos_agreement: true,
    comments_notifications: true,
    replies_notifications: true
  )

  Decidim::User.find_or_initialize_by(email: "user@example.org").update!(
    name: Faker::Name.name,
    password: "decidim123456",
    password_confirmation: "decidim123456",
    confirmed_at: Time.current,
    locale: I18n.default_locale,
    organization: organization,
    tos_agreement: true,
    comments_notifications: true,
    replies_notifications: true
  )
  user = Decidim::User.find_by(email: "user@example.org")

  user_group = Decidim::UserGroup.create!(
    name: "Associació de Veins A",
    document_number: Faker::Number.number(10),
    phone: Faker::PhoneNumber.phone_number,
    verified_at: Time.current,
    decidim_organization_id: organization.id
  )

  Decidim::UserGroupMembership.create!(
    user: user,
    user_group: user_group
  )


  process_groups = []
  3.times do
    process_groups << Decidim::ParticipatoryProcessGroup.create!(
      name: Decidim::Faker::Localized.sentence(3),
      description: Decidim::Faker::Localized.wrapped("<p>", "</p>") do
        Decidim::Faker::Localized.paragraph(3)
      end,
      hero_image: File.new(File.join(seeds_root, "city.jpeg")),
      organization: organization
    )
  end

  3.times do
    Decidim::ParticipatoryProcess.create!(
      title: Decidim::Faker::Localized.sentence(5),
      slug: Faker::Internet.unique.slug(nil, "-"),
      subtitle: Decidim::Faker::Localized.sentence(2),
      hashtag: "##{Faker::Lorem.word}",
      short_description: Decidim::Faker::Localized.wrapped("<p>", "</p>") do
        Decidim::Faker::Localized.sentence(3)
      end,
      description: Decidim::Faker::Localized.wrapped("<p>", "</p>") do
        Decidim::Faker::Localized.paragraph(3)
      end,
      hero_image: File.new(File.join(seeds_root, "city.jpeg")),
      banner_image: File.new(File.join(seeds_root, "city2.jpeg")),
      promoted: true, published_at: 2.weeks.ago,
      organization: organization,
      meta_scope: Decidim::Faker::Localized.word,
      developer_group: Decidim::Faker::Localized.sentence(1),
      local_area: Decidim::Faker::Localized.sentence(2),
      target: Decidim::Faker::Localized.sentence(3),
      participatory_scope: Decidim::Faker::Localized.sentence(1),
      participatory_structure: Decidim::Faker::Localized.sentence(2),
      end_date: 2.month.from_now.at_midnight,
      participatory_process_group: process_groups.sample,
      scope: Faker::Boolean.boolean(0.5) ? nil : Decidim::Scope.reorder("RANDOM()").first
    )
  end

  Decidim::ParticipatoryProcess.find_each do |process|
    Decidim::ParticipatoryProcessStep.find_or_initialize_by(
      participatory_process: process,
      active: true
    ).update!(
      title: Decidim::Faker::Localized.sentence(1, false, 2),
      description: Decidim::Faker::Localized.wrapped("<p>", "</p>") do
        Decidim::Faker::Localized.paragraph(3)
      end,
      start_date: 1.month.ago.at_midnight,
      end_date: 2.months.from_now.at_midnight
    )

    # Create users with specific roles
    Decidim::ParticipatoryProcessUserRole::ROLES.each do |role|
      email = "participatory_process_#{process.id}_#{role}@example.org"

      user = Decidim::User.find_or_initialize_by(email: email)
      user.update!(
        name: Faker::Name.name,
        password: "decidim123456",
        password_confirmation: "decidim123456",
        organization: organization,
        confirmed_at: Time.current,
        locale: I18n.default_locale,
        tos_agreement: true,
        comments_notifications: true,
        replies_notifications: true
      )

      Decidim::ParticipatoryProcessUserRole.find_or_create_by!(
        user: user,
        participatory_process: process,
        role: role
      )
    end

    Decidim::Attachment.create!(
      title: Decidim::Faker::Localized.sentence(2),
      description: Decidim::Faker::Localized.sentence(5),
      file: File.new(File.join(seeds_root, "city.jpeg")),
      attached_to: process
    )

    Decidim::Attachment.create!(
      title: Decidim::Faker::Localized.sentence(2),
      description: Decidim::Faker::Localized.sentence(5),
      file: File.new(File.join(seeds_root, "Exampledocument.pdf")),
      attached_to: process
    )

    2.times do
      Decidim::Category.create!(
        name: Decidim::Faker::Localized.sentence(5),
        description: Decidim::Faker::Localized.wrapped("<p>", "</p>") do
          Decidim::Faker::Localized.paragraph(3)
        end,
        participatory_process: process
      )
    end
  end
end

