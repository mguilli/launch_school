def prompt(msg)
  puts ">> #{msg}"
end

def calculate_sum(num)
  (1..num).sum
end

def calculate_product(num)
  (1..num).reduce(:*)
end

number = operation = nil

loop do
  prompt 'Please enter an integer greater than 0: '
  number = gets.chomp.to_i

  break if number.positive?

  puts '***Invalid input!***'
end

loop do
  prompt "Enter 's' to compute the sum, 'p' to compute the product."
  operation = gets.chomp

  break if %w[s p].include?(operation)

  puts '***Invalid operation selected!***'
end

result = operation == 's' ? calculate_sum(number) : calculate_product(number)
str = %w[sum product].find { |w| w[0] == operation }

puts "The #{str} of the integers between 1 and #{number} is #{result}."