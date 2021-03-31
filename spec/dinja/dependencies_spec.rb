# frozen_string_literal: true

# rubocop:disable RSpec/FilePath
RSpec.describe Dinja::Container do
  subject(:container) { described_class.new }

  before { container.instance_eval File.read(Dinja.root.join("spec/support/dependencies.rb")) }

  it "resolves simple dependencies" do
    dependency = container.resolve("simple")

    expect(dependency.call).to eq "gnirts"
  end

  it "resolves dependencies with argument" do
    dependency = container.resolve("with_argument", "string")

    expect(dependency.call).to eq "gnirts"
  end

  it "resolves dependencies with arguments" do
    dependency = container.resolve("with_arguments", "one", "two")

    expect(dependency.call).to eq %w(two one)
  end

  it "resolves dependencies with block" do
    dependency = container.resolve("with_block") { "string" }

    expect(dependency.call).to eq "gnirts"
  end

  it "resolves dependencies with arguments and block" do
    dependency = container.resolve("with_arguments_and_block", "one", "two", &:reverse)

    expect(dependency.call).to eq %w(owt eno)
  end

  it "resolves recursive dependencies" do
    dependency = container.resolve("recursive", "string")

    expect(dependency.call).to eq "gnirts"
  end
end
# rubocop:enable RSpec/FilePath
