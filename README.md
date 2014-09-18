MetaHash
========

[![Gem Version](http://img.shields.io/gem/v/metahash-rb.svg?style=flat-square)](http://badge.fury.io/rb/metahash-rb)
[![Build Status](http://img.shields.io/travis/NullVoxPopuli/MetaHash.svg?style=flat-square)](https://travis-ci.org/NullVoxPopuli/MetaHash)
[![Code Climate](http://img.shields.io/codeclimate/github/NullVoxPopuli/MetaHash.svg?style=flat-square)](https://codeclimate.com/github/NullVoxPopuli/MetaHash)
[![Test Coverage](http://img.shields.io/codeclimate/coverage/github/NullVoxPopuli/MetaHash.svg?style=flat-square)](https://codeclimate.com/github/NullVoxPopuli/MetaHash)
[![Dependency Status](http://img.shields.io/gemnasium/NullVoxPopuli/MetaHash.svg?style=flat-square)](https://gemnasium.com/NullVoxPopuli/MetaHash)
[![security](https://hakiri.io/github/NullVoxPopuli/MetaHash/master.svg)](https://hakiri.io/github/NullVoxPopuli/MetaHash/master)


Provides a subclass of Hash and a wrapper around Rails' serialize attribute for object-like access to hashes without validating existence of nested hashes

##  Examples
#### Access nested hashes using method / object syntax

Arand new Metadata objects act just like hashes:

    h = Metadata.new
    h
    => {}

Accessing nested data requires no wrapping conditions checking for existence of the rquested data:

    h.outer.inner
    => {}

Possible real-word example:

    if (min_numbers = h.password_rules.formats.numbers.minimum).present?
      # some code using min_numbers
    else
      # data doesn't exist in h

      h.password_rules.formats.numbers.minimum = 1
      # h
      # => { password_rules: { formats: { numbers: { minimum: 1 } } } }
    end

Convert an existing hash to metadata

    {a: 1}.to_metadata.a
    # => 1

#### Access to values stored in nested hashes via method call syntax

    h = Metadata.new( { outer: { inner: { hash_key: "value" } } } )

    h.outer.inner.hash_key
    => "value"

#### Set values for nested hash structures without the nested hashes having to be initially defined

    h = Metadata.new
    h
    => {}

    h.outer.inner = 2
    h
    => { outer: { inner: 2 } }

## Using with ActiveRecord

#### In your Gemfile

    gem "metahash-rb", require: "metahash"

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

[![Analytics](https://ga-beacon.appspot.com/UA-54618821-1/your-repo/page-name)](https://github.com/igrigorik/ga-beacon)
