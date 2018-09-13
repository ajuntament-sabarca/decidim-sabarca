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

from decidim `0.11` to `0.12`

```
  Decidim::Organization.find_each { |organization| Decidim::System::CreateDefaultPages.call(organization) }
```

## Contributing
See [Decidim](https://github.com/decidim/decidim).

## License
See [Decidim](https://github.com/decidim/decidim).
