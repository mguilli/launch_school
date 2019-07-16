def stringy(length, starting_digit = 1)
  str = ''
  # length.times { |i| str << ((i + starting_digit) % 2).to_s }
  length.times { |i| str += (i + starting_digit).odd? ? '1' : '0' }
  str
end

puts stringy(6) == '101010'
puts stringy(6, 0) == '010101'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'