def substrings_at_start(str)
  Array.new(str.length) { |i| str[0..i] }
end

def substrings(str)
  (0...str.length).sum([]) do |i|
    substrings_at_start(str[i..-1])
  end
end

def palindrome?(str)
  str.size > 1 && str == str.reverse
end

def palindromes(str)
  substrings = substrings(str)
  substrings.select { |substr| palindrome?(substr) }
end

p palindromes('abcd') == []
p palindromes('madam') == ['madam', 'ada']
p palindromes('hello-madam-did-madam-goodbye') == [
  'll', '-madam-', '-madam-did-madam-', 'madam', 'madam-did-madam', 'ada',
  'adam-did-mada', 'dam-did-mad', 'am-did-ma', 'm-did-m', '-did-', 'did',
  '-madam-', 'madam', 'ada', 'oo'
]
p palindromes('knitting cassettes') == [
  'nittin', 'itti', 'tt', 'ss', 'settes', 'ette', 'tt'
]
