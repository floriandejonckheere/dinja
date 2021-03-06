# frozen_string_literal: true

require "zeitwerk"

# Simple dependency injection
module Dinja
  class << self
    # Code loader instance
    attr_reader :loader

    def root
      @root ||= Pathname.new(File.expand_path(File.join("..", ".."), __FILE__))
    end

    def setup
      @loader = Zeitwerk::Loader.for_gem

      # Register inflections
      require root.join("config/inflections.rb")

      # Do not eager load integrations
      loader.do_not_eager_load(root.join("lib/dinja/railtie.rb"))
      loader.do_not_eager_load(root.join("lib/dinja/rspec.rb"))

      loader.setup
      loader.eager_load
    end
  end
end

Dinja.setup
