# Domain Search Using GoDaddy API

This Ruby Gem will search [godaddy.com](https://godaddy.com) for website domain availability and pricing using the GoDaddy Developer API.  You can search for a specific domain name or get a list of domains related to any keyword.  If you search for a specific domain and it is not available for purchase, a list of similar domain names will automatically appear.

Note that you cannot make purchases from this Gem, but you can purchase available domains directly on [godaddy.com](https://godaddy.com).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'domain_project'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install domain_project

## Usage

This Gem uses HTTParty for the API interface.  Please install this Gem prior to running the Domain Search Gem. Install using:

    $ gem install httparty

Use the Domain Project Gem to see examples of how the GoDaddy API works.  Getting the API to work properly was the most challenging part of the project.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/'acapp909'/domain_project. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

Written by **Andrew Capp** in conjunction with _Flatiron Academy_ - November 2019

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DomainProject project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/'acapp909'/domain_project/blob/master/CODE_OF_CONDUCT.md).
