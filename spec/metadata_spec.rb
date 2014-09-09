require "spec_helper"

describe Metadata do

  it "is a hash" do
    expect(Metadata.new).to be_kind_of(Hash)
  end

  describe "pruning empty hashes" do
    let(:m){Metadata.new}

    it "removes empty hashes" do
      m.a.b.c
      expect(m.send :prune).to eq Metadata.new
    end

    it "does not remove valid hashes" do
      m.a.b = 2
      expect(m.send :prune).to_not eq Metadata.new
    end

    it "does not pollute itself with empty hashes" do
      m.a.b.c
      expect(m).to eq Metadata.new
    end
  end


  it "sets a non-exsiting deep value" do
    m = Metadata.new
    m.a.b = 2
    expect(m.a.b).to eq 2
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

  it "does not allow hash keys to conflict with the name of a method of the Hash object" do
    expect{
      Metadata.new( outer: { key: "value" } )
    }.to raise_error
  end

end
