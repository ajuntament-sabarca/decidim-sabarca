# frozen_string_literal: true

# You can remove the 'faker' gem if you don't want Decidim seeds.

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
    description: {
      "ca": "<p>L'Ajuntament de Sant Andreu de la Barca vol fomentar la participació, l'atenció ciutadana i la comunicació amb la ciutadania</p>",
      "es": "<p>El Ayuntamiento de Sant Andreu de la Barca quiere fomentar la participación, la atención ciudadana y la comunicación con la ciudadanía</p>"
    },
    default_locale: Decidim.default_locale,
    available_locales: Decidim.available_locales,
    available_authorizations: ["Decidim::Sabarca::DummyAuthorizationHandler"],
    tos_version: Time.current,
    reference_prefix: "sab",
    official_url: "http://sabarca.cat/",
    logo: File.new(File.join(seeds_root.to_s, "logo_sabarca.png")),
    favicon: File.new(File.join(seeds_root.to_s, "favicon_ajsab.png")),
    official_img_header: File.new(File.join(seeds_root.to_s, "logo-ajsab.png")),
    official_img_footer: File.new(File.join(seeds_root.to_s, "logo-footer-ajsab.png"))
  )

  district_scope = Decidim::ScopeType.create!(
    name: Decidim::Faker::Localized.literal("district_scope"),
    plural: Decidim::Faker::Localized.literal("districts"),
    organization: organization
  )

  Decidim::Scope.create!(
    name: Decidim::Faker::Localized.literal("Barri Casc Antic"),
    code: "08740",
    scope_type: district_scope,
    organization: organization
  )

  Decidim::Scope.create!(
    name: Decidim::Faker::Localized.literal("Barri La Colònia"),
    code: "08740",
    scope_type: district_scope,
    organization: organization
  )

  Decidim::Scope.create!(
    name: Decidim::Faker::Localized.literal("Barri de la Plana"),
    code: "08740",
    scope_type: district_scope,
    organization: organization
  )

  Decidim::Scope.create!(
    name: Decidim::Faker::Localized.literal("Barri del Palau"),
    code: "08740",
    scope_type: district_scope,
    organization: organization
  )

  Decidim::Scope.create!(
    name: Decidim::Faker::Localized.literal("Barri La Solana"),
    code: "08740",
    scope_type: district_scope,
    organization: organization
  )

  Decidim::Scope.create!(
    name: Decidim::Faker::Localized.literal("Barri La Unió"),
    code: "08740",
    scope_type: district_scope,
    organization: organization
  )

  Decidim::Scope.create!(
    name: Decidim::Faker::Localized.literal("Centre"),
    code: "08740",
    scope_type: district_scope,
    organization: organization
  )

  Decidim::User.find_or_initialize_by(email: "admin@example.org").update!(
    name: Faker::Name.name,
    nickname: Faker::Lorem.unique.characters(rand(1..20)),
    password: "decidim123456",
    password_confirmation: "decidim123456",
    organization: organization,
    confirmed_at: Time.current,
    locale: I18n.default_locale,
    admin: true,
    tos_agreement: true,
    personal_url: Faker::Internet.url,
    about: Faker::Lorem.paragraph(2),
    accepted_tos_version: organization.tos_version
  )

  Decidim::User.find_or_initialize_by(email: "user@example.org").update!(
    name: Faker::Name.name,
    nickname: Faker::Lorem.unique.characters(rand(1..20)),
    password: "decidim123456",
    password_confirmation: "decidim123456",
    confirmed_at: Time.current,
    locale: I18n.default_locale,
    organization: organization,
    tos_agreement: true,
    personal_url: Faker::Internet.url,
    about: Faker::Lorem.paragraph(2),
    accepted_tos_version: organization.tos_version
  )

  Decidim::User.find_each do |user|
    [nil, Time.current].each do |verified_at|
      user_group = Decidim::UserGroup.create!(
        name: Faker::Company.unique.name,
        nickname: Faker::Twitter.unique.screen_name,
        extended_data: {
          document_number: Faker::Number.number(10),
          phone: Faker::PhoneNumber.phone_number,
          verified_at: verified_at,
          scope_id: 1,
          address: "Plaça de l'Ajuntament 1, 08740 Sant Andreu de la Barca",
          url: Faker::Internet.url
        },
        decidim_organization_id: user.organization.id
      )

      Decidim::UserGroupMembership.create!(
        user: user,
        role: "creator",
        user_group: user_group
      )
    end
  end

  process_groups = []
  3.times do
    process_groups << Decidim::ParticipatoryProcessGroup.create!(
      name: Decidim::Faker::Localized.sentence(3),
      description: Decidim::Faker::Localized.wrapped("<p>", "</p>") do
        Decidim::Faker::Localized.paragraph(3)
      end,
      hero_image: File.new(File.join(seeds_root, "img_sabarca_#{rand(1..6)}.jpg")),
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
      hero_image: File.new(File.join(seeds_root, "img_sabarca_#{rand(1..6)}.jpg")),
      banner_image: File.new(File.join(seeds_root, "img_sabarca_#{rand(1..6)}.jpg")),
      promoted: true, published_at: 2.weeks.ago,
      organization: organization,
      meta_scope: Decidim::Faker::Localized.word,
      developer_group: Decidim::Faker::Localized.sentence(1),
      local_area: Decidim::Faker::Localized.sentence(2),
      target: Decidim::Faker::Localized.sentence(3),
      participatory_scope: Decidim::Faker::Localized.sentence(1),
      participatory_structure: Decidim::Faker::Localized.sentence(2),
      end_date: 2.months.from_now.at_midnight,
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
        nickname: Faker::Lorem.unique.characters(rand(1..20)),
        password: "decidim123456",
        password_confirmation: "decidim123456",
        organization: organization,
        confirmed_at: Time.current,
        locale: I18n.default_locale,
        tos_agreement: true,
        personal_url: Faker::Internet.url,
        about: Faker::Lorem.paragraph(2),
        accepted_tos_version: organization.tos_version
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
      file: File.new(File.join(seeds_root, "img_sabarca_#{rand(1..6)}.jpg")),
      attached_to: process
    )

    Decidim::Attachment.create!(
      title: Decidim::Faker::Localized.sentence(2),
      description: Decidim::Faker::Localized.sentence(5),
      file: File.new(File.join(seeds_root, "Exampledocument.pdf")),
      attached_to: process
    )
  end

  Decidim::StaticPage.create!(
    title: Decidim::Faker::Localized.sentence(2),
    slug: "terms-and-conditions",
    content: Decidim::Faker::Localized.sentence(5),
    organization: organization
  )

  Decidim::Sabarca::TransparencyItem.create!(
    text: Decidim::Faker::Localized.sentence(2),
    url: {
      "ca": Faker::Internet.url,
      "es": Faker::Internet.url
    },
    position: 1,
    decidim_organization_id: organization.id
  )

  3.times do |n|
    Decidim::Sabarca::MayorNeighborhood.create!(
      title: Decidim::Faker::Localized.sentence(2),
      description: Decidim::Faker::Localized.sentence(5),
      location: Decidim::Faker::Localized.sentence(1),
      slug: Faker::Name.suffix,
      start_time: (n + 1).weeks.from_now,
      end_time: (n + 1).weeks.from_now + 4.hours,
      address: Faker::Address.street_address,
      decidim_organization_id: organization.id,
      decidim_scope_id: n + 1
    )
  end

  Decidim::System::CreateDefaultContentBlocks.call(organization)

  hero_content_block = Decidim::ContentBlock.find_by(organization: organization, manifest_name: :hero, scope: :homepage)
  hero_content_block.images_container.background_image = File.new(File.join(seeds_root.to_s, "homepage_image-ajsab.jpg"))
  settings = {}
  welcome_text = {
    "ca": "Volem fomentar la participació",
    "es": "Queremos fomentar la participación"
  }
  settings = welcome_text.inject(settings) { |acc, (k, v)| acc.update("welcome_text_#{k}" => v) }
  hero_content_block.settings = settings
  hero_content_block.save!
end
