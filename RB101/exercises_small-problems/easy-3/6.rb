def xor?(a, b)
  (a || b) && !(a && b)
end

puts xor?(true, false) == true
puts xor?(false, true) == true
puts xor?(false, false) == false
puts xor?(true, true) == false