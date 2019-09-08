def fibonacci(n)
  current = previous = 1
  (n-2).times { current, previous = current + previous, current }
  current
end

p fibonacci(1) == 1
p fibonacci(2) == 1
p fibonacci(3) == 2
p fibonacci(4) == 3
p fibonacci(5) == 5

p fibonacci(20) == 6765
p fibonacci(100) == 354224848179261915075
# p fibonacci(100_001) # => 4202692702.....8285979669707537501
