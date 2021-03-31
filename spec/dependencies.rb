# frozen_string_literal: true

# rubocop:disable Lint/MissingSuper
class Service
  def call; end
end

class WithArgument < Service
  attr_reader :argument

  def initialize(argument)
    @argument = argument
  end
end

class WithArguments < Service
  attr_reader :argument_one, :argument_two

  def initialize(argument_one, argument_two)
    @argument_one = argument_one
    @argument_two = argument_two
  end
end

class WithSplat < Service
  attr_reader :arguments

  def initialize(*arguments)
    @arguments = arguments
  end
end

class WithKeyword < Service
  attr_reader :keyword

  def initialize(keyword:)
    @keyword = keyword
  end
end

class WithKeywords < Service
  attr_reader :keyword_one, :keyword_two

  def initialize(keyword_one:, keyword_two:)
    @keyword_one = keyword_one
    @keyword_two = keyword_two
  end
end

class WithDoubleSplat < Service
  attr_reader :keywords

  def initialize(**keywords)
    @keywords = keywords
  end
end

class WithBlock < Service
  attr_reader :block

  def initialize(&block)
    @block = block
  end
end

class WithEverything < Service
  attr_reader :argument_one, :argument_two, :keyword_one, :keyword_two, :block

  def initialize(argument_one, argument_two, keyword_one:, keyword_two:, &block)
    @argument_one = argument_one
    @argument_two = argument_two
    @keyword_one = keyword_one
    @keyword_two = keyword_two
    @block = block
  end
end

class WithEverythingSplat < Service
  attr_reader :arguments, :keywords, :block

  def initialize(*arguments, **keywords, &block)
    @arguments = arguments
    @keywords = keywords
    @block = block
  end
end
# rubocop:enable Lint/MissingSuper

register("service") do
  Service.new
end

register("with_argument") do |argument|
  WithArgument.new(argument)
end

register("with_arguments") do |argument_one, argument_two|
  WithArguments.new(argument_one, argument_two)
end

register("with_splat") do |*arguments|
  WithSplat.new(*arguments)
end

register("with_keyword") do |keyword:|
  WithKeyword.new(keyword: keyword)
end

register("with_keywords") do |keyword_one:, keyword_two:|
  WithKeywords.new(keyword_one: keyword_one, keyword_two: keyword_two)
end

register("with_double_splat") do |**keywords|
  WithDoubleSplat.new(**keywords)
end

register("with_block") do |&block|
  WithBlock.new(&block)
end

register("with_everything") do |argument_one, argument_two, keyword_one:, keyword_two:, &block|
  WithEverything.new(argument_one, argument_two, keyword_one: keyword_one, keyword_two: keyword_two, &block)
end

register("with_everything_splat") do |*arguments, **keywords, &block|
  WithEverythingSplat.new(*arguments, **keywords, &block)
end

register("recursive") do |argument_one, argument_two|
  WithArguments.new(
    resolve("with_argument", argument_one),
    resolve("with_argument", argument_two),
  )
end
