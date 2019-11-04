class MinilangError < StandardError; end
class InvalidTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  def initialize(command_str)
    @register = 0
    @stack = []
    @program = command_str
  end

  def eval(args = {})
    commands = format(@program, args).split

    commands.each do |command|
      if integer?(command)
        @register = command.to_i
      else
        send command.downcase
      end
    end
  rescue MinilangError => e
    puts e.message
  end

  private

  def method_missing(method_name)
    raise InvalidTokenError, "Invalid token: #{method_name.upcase}" || super
  end

  def respond_to_missing?(method_name, include_all = true)
    super
  end

  def integer?(str)
    str =~ /\d+/
  end

  def print
    puts @register
  end

  def push
    @stack << @register
  end

  def add
    @register += last_stack_value
  end

  def sub
    @register -= last_stack_value
  end

  def mult
    @register *= last_stack_value
  end

  def div
    @register /= last_stack_value
  end

  def mod
    @register %= last_stack_value
  end

  def pop
    @register = last_stack_value
  end

  def last_stack_value
    raise EmptyStackError, 'Empty stack!' if @stack.empty?
    @stack.pop
  end
end

p '----'
Minilang.new('PRINT').eval
# 0

p '----'
Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

p '----'
Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

p '----'
Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

p '----'
Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

p '----'
Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

p '----'
Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

p '----'
Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

p '----'
Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

p '----'
Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)

p Minilang.new('0').respond_to? :invalid

# begin
#   Minilang.new('0').invalid_method
# rescue => exception
#   puts exception.full_message
# end

CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang.eval(degrees_c: 100)
# 212
minilang.eval(degrees_c: 0)
# 32
minilang.eval(degrees_c: -40)
# -40

calculate_area = '%<width>d PUSH %<height>d MULT PRINT'
area = Minilang.new(calculate_area)
area.eval(width: 10, height: 20) # 200
area.eval(width: 7, height: 5) # 35
area.eval(width: 11, height: 3) # 33

puts 'That is all folks!'
