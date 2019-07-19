def multisum(num)
  (1..num).sum(0) { |x| (x % 3 == 0 || x % 5 == 0) ? x : 0 }
  # Further exploration
  # (1..num).reduce(0) { |sum, v| (v % 3 == 0 || v % 5 == 0) ? sum + v : sum }
end

p multisum(3) == 3
p multisum(5) == 8
p multisum(10) == 33
p multisum(1000) == 234168