# frozen_string_literal: true

RSpec.describe Dinja::Container do
  subject(:container) { described_class.new }

  let(:dependency) { ->(arg) { arg.reverse } }

  describe "#register" do
    it "raises when dependency already registered" do
      container.register("foo") { dependency }

      expect { container.register("foo") { dependency } }.to raise_error Dinja::Container::DependencyAlreadyRegistered
    end

    it "registers a dependency" do
      container.register("foo") { dependency }
    end
  end

  describe "#register!" do
    it "does not raise when forcing dependency registration" do
      container.register("foo") { dependency }

      expect { container.register!("foo") { dependency } }.not_to raise_error
    end

    it "registers a dependency" do
      container.register!("foo") { dependency }
    end
  end

  describe "#lookup" do
    it "raises when dependency not registered" do
      expect { container.lookup("foo") }.to raise_error Dinja::Container::DependencyNotRegistered
    end

    it "looks up a dependency" do
      container.register("foo", &dependency)

      expect(container.lookup("foo").call("bar")).to eq "rab"
    end
  end

  describe "#lookup!" do
    it "does not raise when dependency not registered" do
      expect { container.lookup!("foo") }.not_to raise_error
    end

    it "looks up a dependency" do
      container.register("foo", &dependency)

      expect(container.lookup!("foo").call("bar")).to eq "rab"
    end
  end

  describe "#resolve" do
    it "raises when dependency not registered" do
      expect { container.resolve("foo") }.to raise_error Dinja::Container::DependencyNotRegistered
    end

    it "resolves a dependency" do
      container.register("foo") { dependency }

      expect(container.resolve("foo").call("bar")).to eq "rab"
    end
  end

  describe "#resolve!" do
    it "does not raise when dependency not registered" do
      expect { container.resolve!("foo", quiet: true) }.not_to raise_error
    end

    it "resolves a dependency" do
      container.register("foo") { dependency }

      expect(container.resolve!("foo").call("bar")).to eq "rab"
    end
  end
end
