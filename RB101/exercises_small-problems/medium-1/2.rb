def rotate_array(array)
  array.drop(1) + array.take(1)
end

def rotate_rightmost_digits(num, digits)
  number_array = num.to_s.chars
  number_array[-digits..-1] = rotate_array(number_array[-digits..-1])
  number_array.join.to_i
end

p rotate_rightmost_digits(735291, 1) == 735291
p rotate_rightmost_digits(735291, 2) == 735219
p rotate_rightmost_digits(735291, 3) == 735912
p rotate_rightmost_digits(735291, 4) == 732915
p rotate_rightmost_digits(735291, 5) == 752913
p rotate_rightmost_digits(735291, 6) == 352917
