# frozen_string_literal: true

module Dinja
  class Container
    attr_reader :dependencies

    def initialize
      @dependencies = {}
    end

    def register(key, &block)
      raise DependencyAlreadyRegistered, "Dependency already registered: #{key}" if dependencies[key]

      register!(key, &block)
    end

    def register!(key, &block)
      dependencies[key] = block
    end

    def resolve(key, *args, &block)
      return dependencies[key].call(*args, &block) if dependencies[key]

      raise DependencyNotRegistered, "Dependency not registered: #{key}"
    end

    def resolve!(key, *args, &block)
      dependencies[key]&.call(*args, &block)
    end

    class DependencyAlreadyRegistered < StandardError; end

    class DependencyNotRegistered < StandardError; end
  end
end
