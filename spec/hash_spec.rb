require "spec_helper"

describe Hash do
  context "to_metadata" do
    subject(:h){ { a: 1 }.to_metadata }

    it { is_expected.to be_a Metadata }
  end
end