def substrings_at_start(str)
  Array.new(str.length) { |i| str[0..i] }
end

def substrings(str)
  # result = []
  # str.length.times do |i|
  #   result += substrings_at_start(str[i..-1])
  # end
  # result

  (0...str.length).sum([]) do |i|
    substrings_at_start(str[i..-1])
  end
end

p substrings('abcde') == [
  'a', 'ab', 'abc', 'abcd', 'abcde', 
  'b', 'bc', 'bcd', 'bcde',
  'c', 'cd', 'cde',
  'd', 'de',
  'e'
]
