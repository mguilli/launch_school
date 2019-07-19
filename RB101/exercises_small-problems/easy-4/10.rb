def integer_to_string(num)
  num.digits.reverse.join
end

def signed_integer_to_string(num)
  str = ['', '+', '-'][num <=> 0]
  str + integer_to_string(num.abs)
end

p signed_integer_to_string(4321) == '+4321'
p signed_integer_to_string(-123) == '-123'
p signed_integer_to_string(0) == '0'