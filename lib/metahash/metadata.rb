# MetadataHash - A specific use of ruby's Hash
#
# overrides Hash's method missing, providing the following functionality:
# 1. Access Nested hashes using the method / attribute syntax
#   i.e.: h = {}
#     h.middle.inner == {}
#
# 2. Access to values stored in nested hashes via method call syntax
#   i.e.: h = { middle: { inner: { key: "value" } } }
#     h.middle.inner.key == "value"
#
# 3. Set values for nested hash structures without middle nested hashes
#   having to be defined
#   i.e.: h = {}
#     h.middle.inner = 3
#     h == { middle: { inner: 3 } }
#
# 4. Old hash square bracket access still works
#   i.e.: h = { inner: { key: "value" } }
#     h[:inner][:key] == "value"
#
class Metadata < Hash
  include Metaclass
  # in the event we are overriding a method, have a way to
  # get back to the original
  METHOD_BACKUP_KEY = "metadata_original_"

  # the hash being passed in will have all its subhashes converted to
  # metadata hashes.
  # this is needed to we can have the
  #
  # @raise [ArgumentError] if one of the keys is method of Hash
  # @raise [ArgumentError] if hash is not a type of Hash or Metadata
  # @param [Hash] hash the structure to convert to Metadata
  def initialize(hash = {})
    # for maybe instantiating nested hashes that we
    # aren't yet sure if they are going to have values or not
    @empty_nested_hashes = []

    if hash.is_a?(Metadata)
      # we have nothing to do
      return hash
    elsif hash.is_a?(Hash)
      # recursively create nested metadata objects
      hash.each do |key, value|

        self[key] = (
          if value.is_a?(Hash)
            Metadata.new(value)
          elsif value.is_a?(Array)
            # ensure hashes kept in an array are also converted to metadata
            array = value.map{ |element|
              element.is_a?(Hash) ? Metadata.new(element) : element
            }
          else
            value
          end
        )
      end
    else
      raise ArgumentError.new("Field must be a Hash or Metadata")
    end
  end


  # this is what allows functionality mentioned in the class comment to happen
  # @raise [ArgumentError] if one of the keys is method of Hash
  def method_missing(method_name, *args)
    # check for assignment
    if (key = method_name.to_s).include?("=")
      key = key.chop.to_sym

      deepest_metadata = self
      if not @empty_nested_hashes.empty?
        @empty_nested_hashes.each do |key|
          deepest_metadata = deepest_metadata[key] = Metadata.new
        end
        @empty_nested_hashes = []
        deepest_metadata[key] = args[0]
        # override any existing method with the key
        deepest_metadata.meta_def(key){ self[key]}
      else
        self[key] = args[0]
        # override any existing method with the key
        self.meta_def(key){ args[0] }
      end
    else
      value = self[method_name]
      if not value
        @empty_nested_hashes << method_name.to_sym
        value = self
      end
      value
    end

  end

  # Metdata has indifferent access
  def [](key)
    super(key.to_sym)
  end

  # # Metadata has indifferent access,
  # # so just say that all the keys are symbols.
  def []=(key, value)
    super(key.to_sym, value)
  end

  # tests the ability to use this key as a key in a hash
  # @param [Symbol] key
  # @return [Boolean] whether or not this can be used as a hash key
  def valid_key?(key)
    not self.respond_to?(key)
  end

  # convert to regular hash, recursively
  def to_hash
    hash = {}
    self.each do |k,v|
      hash[k] = (
        if v.is_a?(Metadata)
          v.to_hash
        elsif v.is_a?(Array)
          v.map{ |e| e.is_a?(Metadata) ? e.to_hash : e }
        else
          v
        end
      )
    end

    hash
  end

  def to_ary
    self.to_hash.to_a
  end

  alias_method :to_a, :to_ary
end
