# frozen_string_literal: true

module Dinja
  module RSpec
    def dinja_mock!(key, *args)
      mock = instance_double(key)

      allow_any_instance_of(Dinja::Container)
        .to receive(:resolve)
        .and_call_original

      allow_any_instance_of(Dinja::Container)
        .to receive(:resolve)
        .with(key, *args)
        .and_return mock

      mock
    end
  end
end
