# Decidim::Sabarca

The Sabarca module adds custom features to Decidim, for Sant Andreu de la Barca.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'decidim-sabarca', git: 'https://github.com/ajuntament-sabarca/decidim-sabarca.git', branch: 'master'
```

And then execute:
```bash
$ bundle
```

## Upgrading

When upgrading `decidim-sabarca` from version `0.5.0` to `0.9.0` you will also be
upgrading `decidim` version from `0.9.3` to `0.13.1`, the next upgrade notes are
from Decidim's changelog (Connect to your server and run this on your `rails console`):

upgrading Decidim from `0.11` to `0.12`:

```
  Decidim::Organization.find_each { |organization| Decidim::System::CreateDefaultPages.call(organization) }

  Decidim::Meetings::Meeting.find_each(&:add_to_index_as_search_resource)
  Decidim::Proposals::Proposal.find_each(&:add_to_index_as_search_resource)
```

upgrading Decidim from `0.12` to `0.13`:

```
Decidim::User.find_each do |user|
  user.avatar.recreate_versions! if user.avatar?
end
```

## Contributing
See [Decidim](https://github.com/decidim/decidim).

## License
See [Decidim](https://github.com/decidim/decidim).
