CHARMAP = ('0'..'9').zip(0..9).to_h.freeze

def string_to_integer(str)
  digits = str.chars.map { |c| CHARMAP[c] }
  digits.reduce(0) { |memo, x| 10 * memo + x }
end

p string_to_integer('4321') == 4321
p string_to_integer('570') == 570