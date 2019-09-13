def decrease(counter)
  # Integer#-= reassigns a value to the variable 'counter' within the 
  # method, but does not alter the original variable outside the method
  # counter -= 1
  counter - 1
end

counter = 10

counter.times do
  puts counter
  # Since the decrease method does not mutate the original variable passed
  # counter must be assigned the value returned by the method
  # decrease(counter)
  counter = decrease(counter)
end

puts 'LAUNCH!'