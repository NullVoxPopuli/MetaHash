require "spec_helper"

describe Metadata do

  it "is a hash" do
    expect(Metadata.new).to be_kind_of(Hash)
  end

  context 'instance methods' do
    let(:m){ Metadata.new(h) }

    describe "[]" do
      let(:key){h.keys.first}

      it "retrieves with a string key" do
        expect(m[key.to_s]).to eq h[key]
      end

      it "retrieves with a symbol key" do
        expect(m[key.to_sym]).to eq h[key]
      end
    end

    describe "[]=" do

      it 'sets with a string key' do
        m["a"] = 2
        expect(m[:a]).to eq 2
      end

      it 'sets with a symbol key' do
        m[:b] = 2
        expect(m["b"]).to eq 2
      end

    end

    describe "valid_key?" do

      it "is true for keys that aren't methods" do
        expect(m.valid_key?(:b)).to eq true
      end

      it "is false for existing methods" do
        expect(m.valid_key?(:to_hash)).to eq false
      end
    end

    describe "to_hash" do

      it "convets to a hash" do
        expect(m.to_hash).to_not be_kind_of Metadata
      end

    end

    describe "to_ary or to_a" do

      it "converts the hash to an array" do
        expect(m.to_a).to eq m.to_hash.to_a
      end

    end

    describe "initialize" do

      it "copies hash contents" do
        expect(Metadata.new(h)).to eq h
      end
    end

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

    it "can overrid min and max of deeply nested hashes" do
      m.password_rules.formats.digits.max = 3
      m.password_rules.formats.digits.min = 2

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
