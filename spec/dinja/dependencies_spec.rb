# frozen_string_literal: true

# rubocop:disable RSpec/FilePath
RSpec.describe Dinja::Container do
  subject(:container) { described_class.new }

  before { container.instance_eval File.read(Dinja.root.join("spec/dependencies.rb")) }

  it "resolves a service" do
    dependency = container.resolve("service")

    expect(dependency).to respond_to :call
  end

  it "resolves a service with argument" do
    dependency = container.resolve("with_argument", "my_argument")

    expect(dependency.argument).to eq "my_argument"
  end

  it "resolves a service with arguments" do
    dependency = container.resolve("with_arguments", "my_argument_one", "my_argument_two")

    expect(dependency.argument_one).to eq "my_argument_one"
    expect(dependency.argument_two).to eq "my_argument_two"
  end

  it "resolves a service with splat" do
    dependency = container.resolve("with_splat", "my_argument_one", "my_argument_two", "my_argument_three")

    expect(dependency.arguments).to eq %w(my_argument_one my_argument_two my_argument_three)
  end

  it "resolves a service with keyword" do
    dependency = container.resolve("with_keyword", keyword: "my_keyword")

    expect(dependency.keyword).to eq "my_keyword"
  end

  it "resolves a service with keywords" do
    dependency = container.resolve("with_keywords", keyword_one: "my_keyword_one", keyword_two: "my_keyword_two")

    expect(dependency.keyword_one).to eq "my_keyword_one"
    expect(dependency.keyword_two).to eq "my_keyword_two"
  end

  it "resolves a service with double splat" do
    dependency = container.resolve("with_double_splat", keyword_one: "my_keyword_one", keyword_two: "my_keyword_two", keyword_three: "my_keyword_three")

    expect(dependency.keywords).to eq keyword_one: "my_keyword_one", keyword_two: "my_keyword_two",
                                      keyword_three: "my_keyword_three"
  end

  it "resolves a service with block" do
    dependency = container.resolve("with_block") { "my_block" }

    expect(dependency.block.call).to eq "my_block"
  end

  it "resolves a service with everything" do
    dependency = container.resolve("with_everything", "my_argument_one", "my_argument_two", keyword_one: "my_keyword_one", keyword_two: "my_keyword_two") { "my_block" }

    expect(dependency.argument_one).to eq "my_argument_one"
    expect(dependency.argument_two).to eq "my_argument_two"

    expect(dependency.keyword_one).to eq "my_keyword_one"
    expect(dependency.keyword_two).to eq "my_keyword_two"

    expect(dependency.block.call).to eq "my_block"
  end

  it "resolves a service with everything splat" do
    dependency = container.resolve("with_everything_splat", "my_argument_one", "my_argument_two", "my_argument_three", keyword_one: "my_keyword_one", keyword_two: "my_keyword_two", keyword_three: "my_keyword_three") { "my_block" }

    expect(dependency.arguments).to eq %w(my_argument_one my_argument_two my_argument_three)
    expect(dependency.keywords).to eq keyword_one: "my_keyword_one", keyword_two: "my_keyword_two",
                                      keyword_three: "my_keyword_three"
    expect(dependency.block.call).to eq "my_block"
  end

  it "resolves recursive dependencies" do
    dependency = container.resolve("recursive", "my_argument_one", "my_argument_two")

    expect(dependency.argument_one.argument).to eq "my_argument_one"
    expect(dependency.argument_two.argument).to eq "my_argument_two"
  end
end
# rubocop:enable RSpec/FilePath
