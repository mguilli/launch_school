module VariableModule
  attr_accessor :shared_var

  def initialize
    @shared_var = 0
  end
end

class TestClass
  include VariableModule
end

test1 = TestClass.new
test2 = TestClass.new
test1.shared_var = 4
p test1
puts test1.shared_var
p test2
puts test2.shared_var
