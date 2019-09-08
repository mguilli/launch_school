def word_to_digit(str)
  digits = %w[zero one two three four five six seven eight nine]
  pattern = /\b#{Regexp.union(digits)}\b/
  str.gsub(pattern) { |match| digits.index(match).to_s }
end

p word_to_digit('Please call me at five five five one two three four. Thanks.') == 'Please call me at 5 5 5 1 2 3 4. Thanks.'
p word_to_digit('Call the freight phone when you get this.')
