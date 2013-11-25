MetaHash
========

Provides a subclass of Hash and a wrapper around Rails' serialize attribute for object-like access to hashes without validating existence of nested hashes

##  Examples
### Access nested hashes using method / object syntax

 	h = Metadata.new
 	h # => {}
 	h.outer.inner # => {}

### Access to values stored in nested hashes via method call syntax

	h = Metadata.new( { outer: { inner: { hash_key: "value" } } } )
	h.outer.inner.hash_key # => "value"
	
### Set values for nested hash structures without the nested hashes having to be initially defined

	h = Metadata.new( {} )

 ## Using with ActiveRecord

	


## Support

This gem has been tested with Ruby 2.0, and rails 3.2


## Contributing

1. Fork the project
2. Create a new, descriptively named branch
3. Add Test(s)!
4. Commit your proposed changes
5. Submit a pull request
