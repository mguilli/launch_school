def multiply(x,y)
  x * y
end

def square(n)
  multiply(n, n)
end

puts multiply(5, 3) == 15
puts square(5) == 25
puts square(-8) == 64

# Further exploration
def power(n, exp)
  result = 1
  exp.times { result = multiply(n, result) }
  result
end

puts power(2, 3) == 8
puts power(3, 5) == 243