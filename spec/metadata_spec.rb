require "spec_helper"

describe Metadata do

  it "is a hash" do
    expect(Metadata.new).to be_kind_of(Hash)
  end

  describe "pruning empty hashes" do
    let(:m){Metadata.new}

    it "removes empty hashes" do
      m.a.b.c
      expect(m.a.b.c).to eq Metadata.new
    end

    it "does not remove valid hashes" do
      m.a.b = 2
      expect(m.a.b).to_not eq Metadata.new
    end

    it "does not remove valid hashes of long chains" do
      m.a.b.c.d.e = 2
      expect(m.a.b.c.d.e).to eq 2
    end

    it "does not pollute itself with empty hashes" do
      m.a.b.c
      expect(m).to eq Metadata.new
    end
  end

  context "assigns values" do
    let(:m){Metadata.new}

    it "sets a non-exsiting deep value" do
      m.a.b = 2
      expect(m.a.b).to eq 2
    end

    it "sets with specific keys" do
      m.a.min = 2
      m.a.max = 3
      expect(m.a.min).to eq 2
      expect(m.a.max).to eq 3
    end

    it "overrides existing methods if set" do
      m.keys = 2
      expect(m.keys).to eq 2
    end

    it "overrides existing methods if set to non-simple objects" do
      m.a.b = 2
      m.a.keys = 3
      expect(m.a.keys).to eq 3
    end

  end



  it "has indifferent access" do
    m = Metadata.new(a: 2)
    expect(m.a).to eq 2
    expect(m[:a]).to eq 2
    expect(m["a"]).to eq 2
  end

  it "allows method-style access to nested hashes" do
    m = Metadata.new(h)
    expect(m.outer.inner.k).to eq h[:outer][:inner][:k]
  end

  it "allows hash-style access to nested hashes" do
    m = Metadata.new(h)
    expect(m[:outer][:inner][:k]).to eq h[:outer][:inner][:k]
  end

end
