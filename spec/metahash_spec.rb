require "spec_helper"

describe MetaHash do


    before(:each) do
      m = TestObject.new(metadata: h, name: "MetaHash")
      m.save
    end

    after(:each) do
      TestObject.destroy_all
    end

    it "converts the chose field to Metadata" do
      p = TestObject.last
      expect(p.metadata).to be_kind_of(Metadata)
    end

    it "instantiates with an empty hash if the field is nil" do
      p = TestObject.new
      p.metadata = nil
      p = TestObject.last
      expect(p.metadata).to_not be_nil
      expect(p.metadata).to be_kind_of(Metadata)
    end

    it "does not modify the original contents of the chosen field on initialization" do
      p = TestObject.last
      expect(p.metadata.to_hash).to eq Metadata.new(h)
    end

    it "creates an alias for the original field's data" do
      p = TestObject.last
      expect(p.metadata_original).to eq Metadata.new(h)
    end

    it "doesn't error when a the attribute is not included in the retrieval of a record" do
      expect{
        p = TestObject.select("name")
      }.to_not raise_error
    end

    it "converts the field back to a Hash before saving to the database" do
      db = ActiveRecord::Base.connection.select_all("
          SELECT metadata
          FROM test_objects
        ").last
      p = db["metadata"]
      expect(JSON.load(p)).to eq JSON.load(h.to_json)
    end


end
