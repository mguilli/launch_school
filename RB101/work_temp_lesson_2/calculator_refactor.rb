def prompt(message)
  puts "=> #{message}"
end

prompt('Welcome to Calculator!')

prompt('What is the first number?')
num1 = gets.chomp.to_i

prompt('What is the second number?')
num2 = gets.chomp.to_i

prompt('What operation would you like to perform?')
prompt('1 - Add')
prompt('2 - Subtract')
prompt('3 - Multiply')
prompt('4 - Divide')
operator = gets.chomp.to_i

result = case operator
         when 1
           num1 + num2
         when 2
           num1 - num2
         when 3
           num1 * num2
         when 4
           num2 / num2.to_f
         else
           return(prompt('No valid operator specified!'))
end

prompt("Your result is: #{result}")