puts 'Welcome to Calculator!'

puts 'What is the first number?'
number1 = gets.chomp.to_i

puts 'What is the second number?'
number2 = gets.chomp.to_i

puts 'What operation do you want to perform?'
puts '1 - Add'
puts '2 - Subtract'
puts '3 - Multiply'
puts '4 - Divide'
operation = gets.chomp.to_i

case operation
when 1
  result = number1 + number2
when 2
  result = number1 - number2
when 3
  result = number1 * number2
when 4
  result = number1 / number2.to_f
else
  return(puts 'No valid operation selected')
end

puts "Your result is: #{result}"
