# Preserve zero digit during rotation

def rotate_array(array)
  array.drop(1) + array.take(1)
end

def rotate_rightmost_digits(str, digits)
  number_array = str.chars
  number_array[-digits..-1] = rotate_array(number_array[-digits..-1])
  number_array.join
end

def max_rotation(num)
  str = num.to_s
  (str.size).downto(1) do |digits|
    str = rotate_rightmost_digits(str, digits)
  end
  str.to_i
end

p max_rotation(735291) == 321579
p max_rotation(3) == 3
p max_rotation(35) == 53
p max_rotation(105) == 15 # the leading zero gets dropped
p max_rotation(8_703_529_146) == 7_321_609_845
p max_rotation(1005) == 501
