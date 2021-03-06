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

### Standalone

```ruby
# Instantiate a dependency injection container
container = Dinja::Container.new

# Register a dependency
container.register("my_dependency") { |name| OpenStruct.new(name: name) }

# Resolve a dependency
my_dependency = container.resolve("my_dependency", "foobar")

puts my_dependency.name
# => "foobar"

# Look up a dependency (without resolving)
my_dependency = container.lookup("my_dependency")
puts my_dependency.call("foobar")
# => #<OpenStruct name="foobar">

# Container#resolve will raise when trying to resolve unregistered dependencies
# Use Container#resolve! to resolve unregistered dependencies without raising (dangerous)
container.resolve("another_dependency")
# => DependencyNotRegistered

# Container#lookup will raise when trying to look up unregistered dependencies
# Use Container#lookup! to look up unregistered dependencies without raising (dangerous)
container.lookup("another_dependency")
# => DependencyNotRegistered

# Container#register will raise when trying to overwrite registered dependencies
# Use Container#register! to overwrite dependencies (dangerous)
container.register("my_dependency") { |name| OpenStruct.new(name: name) }
```

### Rails

In a Rails application, add the following line to your `config/application.rb`:

```ruby
require "dinja/railtie"
```

Create `config/dependencies.rb` and register some dependencies:

```ruby
register("my_dependency") do |name|
  OpenStruct.new(name: name)
end
```

A dependency injection container is now available throughout your application on `Rails.application.config.container`:

```ruby
my_dependency = Rails.application.config.container.resolve("my_dependency", "foobar")

my_dependency.name
# => "foobar"
```

### Gem

In a gem, add the following lines to your `lib/my_gem.rb`:

```ruby
require "dinja"

module MyGem
  def container
    @container ||= Dinja::Container.new 
  end

  def setup
    # ...other stuff here

    # Register dependencies
    container.instance_eval(File.read("config/dependencies.rb"))
  end
end

MyGem.setup
```

Create `config/dependencies.rb` and register some dependencies:

```ruby
register("my_dependency") do |name|
  OpenStruct.new(name: name)
end
```

A dependency injection container is now available throughout your application on `MyGem.container`:

```ruby
my_dependency = MyGem.container.resolve("my_dependency", "foobar")

my_dependency.name
# => "foobar"
```

### RSpec

If you need to mock resolution calls to a container, you can do as following.

In `spec/rails_helper.rb` or `spec/spec_helper.rb`:

```ruby
require "dinja/rspec"
include Dinja::RSpec
```

In `config/dependencies.rb`:

```ruby
register("my_service") do |name|
  OpenStruct.new(name: name)
end
```

In `spec/my_app/my_model_spec.rb`:

```ruby
RSpec.describe MyApp::MyModel do
  subject(:my_model) { described_class.new }

  it "calls my service" do
    my_service = dinja_mock!("my_service")

    allow(my_service)
      .to receive(:call)
      .and_return true

    my_model.call_service

    expect(my_service).to have_received(:call)
  end
end

```

## Development

To release a new version, update the version number in `lib/dinja/version.rb`, update the changelog, commit the files and create a git tag starting with `v`, and push it to the repository.
Github Actions will automatically run the test suite, build the `.gem` file and push it to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/floriandejonckheere/dinja](https://github.com/floriandejonckheere/dinja). 

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
