# frozen_string_literal: true

module Dinja
  module Version
    MAJOR = 1
    MINOR = 1
    PATCH = 0
    PRE   = nil

    VERSION = [MAJOR, MINOR, PATCH].compact.join(".")

    STRING = [VERSION, PRE].compact.join("-")
  end

  VERSION = Version::STRING
end
