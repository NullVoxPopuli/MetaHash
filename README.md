MetaHash
========

[![Gem Version](https://badge.fury.io/rb/metahash-rb.svg)](http://badge.fury.io/rb/metahash-rb)
[![](https://ci.solanolabs.com:443/TinderBox/MetaHash/badges/110842.png?badge_token=a5097ea0ff487d291e94285ed9e4c8fabeca5fd1)](https://ci.solanolabs.com:443/TinderBox/MetaHash/suites/110842)
[![Code Climate](https://codeclimate.com/github/NullVoxPopuli/MetaHash/badges/gpa.svg)](https://codeclimate.com/github/NullVoxPopuli/MetaHash)
[![Dependency Status](https://gemnasium.com/NullVoxPopuli/MetaHash.svg)](https://gemnasium.com/NullVoxPopuli/MetaHash)
[![Test Coverage](https://codeclimate.com/github/NullVoxPopuli/MetaHash/badges/coverage.svg)](https://codeclimate.com/github/NullVoxPopuli/MetaHash)



Provides a subclass of Hash and a wrapper around Rails' serialize attribute for object-like access to hashes without validating existence of nested hashes

##  Examples
#### Access nested hashes using method / object syntax

    h = Metadata.new
    h # => {}
    h.outer.inner # => {}

#### Access to values stored in nested hashes via method call syntax

    h = Metadata.new( { outer: { inner: { hash_key: "value" } } } )
    h.outer.inner.hash_key # => "value"

#### Set values for nested hash structures without the nested hashes having to be initially defined

    h = Metadata.new( {} )

## Using with ActiveRecord

#### In your Gemfile

    gem "metahash-rb"

#### in your ActiveRecord model

    has_metadata

or

    has_metadata :field_not_called_metadata


## Support

This gem has been tested with Ruby 2.0, and rails 3.2, 4.1


## Contributing

1. Fork the project
2. Create a new, descriptively named branch
3. Add Test(s)!
4. Commit your proposed changes
5. Submit a pull request
