OPERATORS = %i[+ - * / % **]

def prompt(msg)
  puts "==> #{msg}"
end

prompt 'Enter the first number:'
first = gets.to_i
prompt 'Enter the second number'
second = gets.to_i

OPERATORS.each do |operation|
  calculation = [first,second].reduce(operation)
  prompt "#{first} #{operation} #{second} = #{calculation}"
end