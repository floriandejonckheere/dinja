# frozen_string_literal: true

require "rails"

require_relative "../dinja"

module Dinja
  # Dinja Railtie
  class Railtie < Rails::Railtie
    config.container = Dinja::Container.new

    config.container.instance_eval(File.read(File.join("config/dependencies.rb")))
  end
end
