sequence = "112358314594370774156178538190998752796516730336954932572910"
SERIES = sequence.chars.map(&:to_i)

def fibonacci_series
  numbers = [1, 1]
  500.times { numbers << (numbers[-1] + numbers[-2]) % 10 }
  str = numbers.join

  loop do
    repeated = str.match(/(.+)\1/)
    break unless repeated && repeated[1].size > 10
    str = repeated[1]
  end
  str
end

def fibonacci_last(n)
  # current = previous = 1
  # (n-2).times do 
  #   current, previous = (current + previous) % 10, current
  # end
  # current

  # further exploration
  n %= 60
  SERIES[n - 1]
end

p fibonacci_last(15)        # -> 0  (the 15th Fibonacci number is 610)
p fibonacci_last(20)        # -> 5 (the 20th Fibonacci number is 6765)
p fibonacci_last(100)       # -> 5 (the 100th Fibonacci number is 354224848179261915075)
p fibonacci_last(100_001)   # -> 1 (this is a 20899 digit number)
p fibonacci_last(1_000_007) # -> 3 (this is a 208989 digit number)
p fibonacci_last(123456789) # -> 4
