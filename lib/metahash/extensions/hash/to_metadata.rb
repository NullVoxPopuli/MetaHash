class Hash
  # Returns a copy of self represented as a Metahash
  #
  # m = { a: 1 }.to_metadata
  # m.a # => 1
  def to_metadata
    Metadata.new(self)
  end
end