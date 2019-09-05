def substrings_at_start(str)
  1.upto(str.length).map { |i| str[0, i] }
  Array.new(str.length) { |i| str[0..i] }
end

p substrings_at_start('abc') == ['a', 'ab', 'abc']
p substrings_at_start('a') == ['a']
p substrings_at_start('xyzzy') == ['x', 'xy', 'xyz', 'xyzz', 'xyzzy']
