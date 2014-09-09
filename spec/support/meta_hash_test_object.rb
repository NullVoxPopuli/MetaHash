class MetaHashTestObject < FakeAR

  attr_accessor :metadata, :name

  def initialize(attributes = {})
    @metadata = attributes[:metadata]
    super(attributes)
  end

end
