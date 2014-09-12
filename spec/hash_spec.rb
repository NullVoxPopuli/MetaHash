require "spec_helper"

describe Hash do
  context "to_metadata" do
    subject(:h){ { a: 1 }.to_metadata }

    it "is a Metadata" do
      expect(h).to be_a Metadata
    end

    it "behaves like a Metdata" do
      expect(h.a).to eq 1
    end
  end

end