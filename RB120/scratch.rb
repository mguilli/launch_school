module Specialty
  # def initialize(value)
  #   @module = value
  # end
end

class SuperClass
  def initialize(value)
    @superclass = value
  end
end

class SubClass < SuperClass
  include Specialty
  def initialize(value, other_value)
    @subclass = other_value
    super(value)
  end
end

p SubClass.ancestors
p SubClass.new(10, 42)
