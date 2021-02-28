# frozen_string_literal: true

require_relative "lib/dinja/version"

Gem::Specification.new do |spec|
  spec.name          = "dinja"
  spec.version       = Dinja::VERSION
  spec.authors       = ["Florian Dejonckheere"]
  spec.email         = ["florian@floriandejonckheere.be"]

  spec.summary       = "Simple Dependency Injection container"
  spec.description   = "Dinja, Dependency Injection Ninja allows you to decouple abstractions from implementations"
  spec.homepage      = "https://github.com/floriandejonckheere/dinja"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6")

  spec.metadata["source_code_uri"] = "https://github.com/floriandejonckheere/dinja.git"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir["README.md", "LICENSE.md", "CHANGELOG.jd", "Gemfile", "lib/**/*.rb", "config/**/*.rb"]
  spec.bindir        = "bin"
  spec.executables   = []
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "zeitwerk"

  spec.add_development_dependency "byebug"
  spec.add_development_dependency "debase"
  spec.add_development_dependency "factory_bot"
  spec.add_development_dependency "fasterer"
  spec.add_development_dependency "flay"
  spec.add_development_dependency "overcommit"
  spec.add_development_dependency "pronto"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "reek"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "rubocop-rspec"
end
