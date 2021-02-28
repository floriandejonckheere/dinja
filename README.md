# Dinja

![Continuous Integration](https://github.com/floriandejonckheere/dinja/workflows/Continuous%20Integration/badge.svg)
![Release](https://img.shields.io/github/v/release/floriandejonckheere/dinja?label=Latest%20release)

Dinja, Dependency Injection Ninja

## Installation

Add this line to your application's Gemfile:

```ruby
gem "dinja"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install dinja

## Usage

```ruby
# Instantiate a dependency injection container
container = Dinja::Container.new

# Register a dependency
container.register("my_dependency") { |name| OpenStruct.new(name: name) }

# Resolve a dependency
my_dependency = container.resolve("my_dependency", "foobar")

puts my_dependency.name
# => "foobar"

# container.resolve will raise when trying to resolve unregistered dependencies
# Use container.resolve! to resolve unregistered dependencies without raising (dangerous)
container.resolve("another_dependency")
# => DependencyNotRegistered

# container.register will raise when trying to overwrite registered dependencies
# Use container.register! to overwrite dependencies (dangerous)
container.register("my_dependency") { |name| OpenStruct.new(name: name) }
```

## Development

To release a new version, update the version number in `lib/dinja/version.rb`, commit it and create a git tag starting with `v`, and push it to the repository.
Github Actions will automatically run the test suite, build the `.gem` file and push it to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/floriandejonckheere/dinja](https://github.com/floriandejonckheere/dinja). 

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
