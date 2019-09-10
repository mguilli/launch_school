LIMIT = 9876543201

def is_featured?(num)
  num % 7 == 0 && num.odd? && num.digits.size == num.digits.uniq.size
end

def featured(num)
  start = ((num / 7) + 1) * 7
  (start..LIMIT).find { |x| is_featured?(x) } || 'No solution'
end


p featured(LIMIT-1)
p featured(12) == 21
p featured(20) == 21
p featured(21) == 35
p featured(997) == 1029
p featured(1029) == 1043
p featured(999_999) == 1_023_547
p featured(999_999_987) == 1_023_456_987

p featured(9_999_999_999) # -> There is no possible number that fulfills those requirements
