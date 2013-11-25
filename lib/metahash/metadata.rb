# MetadataHash - A specific use of ruby's Hash
#
# overrides Hash's method missing, providing the following functionality:
# 1. Access Nested hashes using the method / attribute syntax
#     i.e.: h = {}
#             h.middle.inner == {}
#
# 2. Access to values stored in nested hashes via method call syntax
#     i.e.: h = { middle: { inner: { key: "value" } } }
#             h.middle.inner.key == "value"
#
# 3. Set values for nested hash structures without middle nested hashes
#     having to be defined
#     i.e.: h = {}
#             h.middle.inner = 3
#             h == { middle: { inner: 3 } }
#
# 4. Old hash square bracket access still works
#     i.e.: h = { inner: { key: "value" } }
#             h[:inner][:key] == "value"
#
class Metadata < Hash

	# the hash being passed in will have all its subhashes converted to
	# metadata hashes.
	# this is needed to we can have the
	#
	# @raise [ArgumentError] if one of the keys is method of Hash
	# @raise [ArgumentError] if hash is not a type of Hash or Metadata
	# @param [Hash] hash the structure to convert to Metadata
	def initialize(hash = {})
		if hash.is_a?(Metadata)
			# we have nothing to do
			return hash
		elsif hash.is_a?(Hash)
			# recursively create nested metadata objects
			hash.each do |key, value|
				if not valid_key?(key)
					raise ArgumentError.new("Not Allowed. '#{key}' is a reserved method.")
				end

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
			raise ArgumentError.new("Not Allowed. '#{key}' is a reserved method.") if self.methods.include?(key)
			self[key] = args[0]
		else
			(value = self[method_name]) ? value : (self[method_name] = Metadata.new)
		end
	end

	# tests the ability to use this key as a key in a hash
	# @param [Symbol] key
	# @return [Boolean] whether or not this can be used as a hash key
	def valid_key?(key)
		not self.methods.include?(key)
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
end
