# frozen_string_literal: true

module Dinja
  module Version
    MAJOR = 2
    MINOR = 0
    PATCH = 0
    PRE   = nil

    VERSION = [MAJOR, MINOR, PATCH].compact.join(".")

    STRING = [VERSION, PRE].compact.join("-")
  end

  VERSION = Version::STRING
end
