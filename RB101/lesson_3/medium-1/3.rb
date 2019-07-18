def factors(number)
  divisor = number
  factors = []

  while divisor > 0
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end

  factors
end

p factors(4) == [1, 2, 4]
p factors(0) == []
p factors(-4) == []

# number % divisor is a conditional expression that only adds an element to the 
# factors array if number is evenly divisible by divisor

# The last line of the method (factors) is present to return the value of the 
# factors array as the method return value