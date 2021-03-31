# frozen_string_literal: true

class MyService
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def call
    input.reverse
  end
end

# Simple
register("simple") do
  MyService.new("string")
end

# With argument
register("with_argument") do |arg|
  MyService.new(arg)
end

# With arguments
register("with_arguments") do |*args|
  MyService.new(args)
end

# With block
register("with_block") do |&block|
  MyService.new(block.call)
end

# With arguments and block
register("with_arguments_and_block") do |*args, &block|
  MyService.new(args.map { |arg| block.call(arg) })
end

# Recursive
register("recursive") do |arg|
  resolve("with_argument", arg)
end
