require "spec_helper"		

describe Metadata do
	let(:h){
		{
			outer: {
				inner: {
					k: "value"
				}
			}
		}
	}

	it "is a hash" do
		Metadata.new.should be_kind_of(Hash)
	end

	it "allows method-style access to nested hashes" do
		m = Metadata.new(h)
		m.outer.inner.k.should == h[:outer][:inner][:k]
	end

	it "allows hash-style access to nested hashes" do
		m = Metadata.new(h)
		m[:outer][:inner][:k].should == h[:outer][:inner][:k]
	end

	it "does not allow hash keys to conflict with the name of a method of the Hash object" do
		expect{
			Metadata.new( outer: { key: "value" } )
		}.to raise_error
	end

	context "'ActiveRecord' attribute integration" do

		before(:each) do
			m = MetaHashTestObject.new(metadata: h, name: "MetaHash")
			m.save
			MetaHashTestObject.send(:extend, MetaHash)
			MetaHashTestObject.send(:metadata_field_for, :metadata)
		end

		after(:each) do
			MetaHashTestObject.destroy_all
		end

		it "converts the chose field to Metadata" do
			p = MetaHashTestObject.last
			p.metadata.should be_kind_of(Metadata)
		end

		it "instantiates with an empty hash if the field is nil" do
			p = MetaHashTestObject.new
			p.metadata = nil
			p = MetaHashTestObject.last
			p.metadata.should_not be_nil
			p.metadata.should be_kind_of(Metadata)
		end

		it "does not modify the original contents of the chosen field on initialization" do
			p = MetaHashTestObject.last
			p.metadata.to_hash.should == h
		end

		it "creates an alias for the original field's data" do
			p = MetaHashTestObject.last
			p.metadata_original.should == h
		end

		it "doesn't error when a the attribute is not included in the retrieval of a record" do
			expect{
				p = MetaHashTestObject.select("name")
			}.to_not raise_error
		end

		it "converts the field back to a Hash before saving to the database" do
			if defined?(Rails)
				db = ActiveRecord::Base.connection.select_all("
					SELECT metadata
					FROM proposals
				").last
				p = db["metadata"]
				YAML.load(p).should == YAML.load(h.to_yaml)
			else
				pending("Rails not present")
			end
		end

	end


end
