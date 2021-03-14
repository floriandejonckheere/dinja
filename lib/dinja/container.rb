# frozen_string_literal: true

module Dinja
  # Dependency injection container
  class Container
    attr_reader :dependencies

    def initialize
      @dependencies = {}
    end

    # Register a dependency
    #
    # @param [String] key The unique key under which the dependency will be registered
    # @param [Proc] &block The proc to be called when resolving the dependency
    #
    # @raise [DependencyAlreadyRegistered] If the dependency was already registered before
    #
    def register(key, &block)
      raise DependencyAlreadyRegistered, "Dependency already registered: #{key}" if dependencies.key?(key)

      register!(key, &block)
    end

    # Register or overwrite an existing dependency
    #
    # @param [String] key The unique key under which the dependency will be registered
    # @param [Proc] &block The proc to be called when resolving the dependency
    #
    def register!(key, &block)
      dependencies[key] = block
    end

    # Look up a dependency without resolving it
    #
    # @param [String] key The unique name under which the dependency was registered
    #
    # @raise [DependencyNotRegistered] If the dependency was not registered
    #
    def lookup(key)
      raise DependencyNotRegistered, "Dependency not registered: #{key}" unless dependencies.key?(key)

      dependencies[key]
    end

    # Look up a dependency without resolving it
    #
    # @param [String] key The unique name under which the dependency was registered
    #
    def lookup!(key)
      dependencies[key]
    end

    # Resolve a dependency
    #
    # @param [String] key The unique key under which the dependency was registered
    # @param [Object] *args The arguments to pass when resolving the dependency
    # @param [Proc] &block The block to pass when resolving the dependency
    #
    # @raise [DependencyNotRegistered] If the dependency was not registered
    #
    def resolve(key, *args, **kwargs, &block)
      lookup(key).call(*args, **kwargs, &block)
    end

    # Resolve a dependency
    #
    # @param [String] key The unique key under which the dependency was registered
    # @param [Object] *args The arguments to pass when resolving the dependency
    # @param [Proc] &block The block to pass when resolving the dependency
    #
    def resolve!(key, *args, **kwargs, &block)
      lookup!(key)&.call(*args, **kwargs, &block)
    end

    # Raised when trying to overwrite a dependency that was already registered
    class DependencyAlreadyRegistered < StandardError; end

    # Raised when trying to resolve a dependency that was not registered
    class DependencyNotRegistered < StandardError; end
  end
end
