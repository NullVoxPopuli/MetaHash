class FakeAR

  @@table = []
  @@callbacks = {
    after_initialize: [],
    after_save: [],
    before_save: []
  }

  def self.attr_accessor(*vars)
    @attributes ||= []
    @attributes.concat(vars)
    super(*vars)
  end
  def self.attributes; @attributes || []; end
  def self.has_attribute?(attribute); attributes.include?(attribute); end
  def attributes; self.class.attributes; end

  def has_attribute?(attribute)
    self.class.has_attribute?(attribute)
  end

  def initialize(*args)
    after_initialize
  end

  def self.last; l = @@table.last; l.after_initialize; l; end
  def self.first; f = @@table.first; f.after_initialize; f; end
  def self.destroy_all; @@table = []; end
  def self.after_initialize(&block); @@callbacks[:after_initialize] << block; end
  def self.before_save(&block); @@callbacks[:before_save] << block; end
  def self.after_save(&block); @@callbacks[:after_save] << block; end
  def self.create(args); s = self.new(args); s.save; s.after_initialize; s; end

  def save
    before_save
    @@table << self
    after_save
  end

  def self.select(attribute)
    self.new(attribute => @@table.first.send(attribute) )
  end

  def after_initialize
    @@callbacks[:after_initialize].each do |callback|
      callback.call(self)
    end
  end

  def after_save
    @@callbacks[:after_save].each do |callback|
      callback.call(self)
    end
  end

  def before_save
    @@callbacks[:before_save].each do |callback|
      callback.call(self)
    end
  end

end
