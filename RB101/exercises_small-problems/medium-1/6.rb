def integer?(str)
  str.to_i != 0 || str == '0'
end

def minilang(str)
  register = 0
  commands = str.split
  stack = []

  commands.each do |command|
    if integer?(command)
      register = command.to_i
    else
      case command
      when 'PUSH' then stack << register
      when 'PRINT' then puts register
      else
        return(puts "Error: stack empty") if stack.empty?
        case command
        when 'ADD' then register += stack.pop
        when 'SUB' then register -= stack.pop
        when 'MULT' then register *= stack.pop
        when 'DIV' then register /= stack.pop
        when 'MOD' then register %= stack.pop
        when 'POP' then register = stack.pop
        else
          return(puts "Error: invalid command")
        end
      end
    end
  end
  nil
end

puts 'start program'
minilang('PRINT')
# 0
puts 'start program'
minilang('5 PUSH 3 MULT PRINT')
# 15
puts 'start program'
minilang('5 PRINT PUSH 3 PRINT ADD PRINT')
# 5
# 3
# 8
puts 'start program'
minilang('5 PUSH POP PRINT')
# 5
puts 'start program'
minilang('3 PUSH 4 PUSH 5 PUSH PRINT ADD PRINT POP PRINT ADD PRINT')
# 5
# 10
# 4
# 7
puts 'start program'
minilang('3 PUSH PUSH 7 DIV MULT PRINT ')
# 6
puts 'start program'
minilang('4 PUSH PUSH 7 MOD MULT PRINT ')
# 12
puts 'start program'
minilang('-3 PUSH 5 SUB PRINT')
# 8
puts 'start program'
result = minilang('6 PUSH')
p result # nil due to successful program completion
# nothing printed (no PRINT commands)
minilang('ADD PRINT') # Error empty stack
minilang('5 PUSH 6 PROWL') # Error invalid command
string = '3 PUSH 5 MOD PUSH 4 PUSH 5 MULT PUSH 3 PUSH -7 ADD ADD PUSH POP DIV PRINT'
minilang(string)
