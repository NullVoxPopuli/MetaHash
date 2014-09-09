# http://reference.jumpingmonkey.org/programming_languages/ruby/ruby-metaprogramming.html
# allows the adding of methods to instances,
# but not the entire set of instances for a
# particular class
module Metaclass
  # The hidden singleton lurks behind everyone
  def metaclass; class << self; self; end; end
  def meta_eval &blk; metaclass.instance_eval &blk; end

  # Adds methods to a metaclass
  def meta_def( name, &blk )
    meta_eval { define_method name, &blk }
  end

  # Defines an instance method within a class
  def class_def( name, &blk )
    class_eval { define_method name, &blk }
  end
end
