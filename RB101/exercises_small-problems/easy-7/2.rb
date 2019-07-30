# def letter_case_count(str)
#   result = {lowercase: 0, uppercase: 0, neither: 0}

#   str.chars.each do |c|
#     case c
#     when /[a-z]/ then result[:lowercase] += 1
#     when /[A-Z]/ then result[:uppercase] += 1
#     else result[:neither] += 1
#     end
#   end

#   result
# end

def letter_case_count(str)
  lower = str.count 'a-z'
  upper = str.count 'A-Z'
  neither = str.count '^a-zA-Z'
  {lowercase: lower, uppercase: upper, neither: neither}
end

p letter_case_count('abCdef 123')
p letter_case_count('abCdef 123') == { lowercase: 5, uppercase: 1, neither: 4 }
p letter_case_count('AbCd +Ef') == { lowercase: 3, uppercase: 3, neither: 2 }
p letter_case_count('123') == { lowercase: 0, uppercase: 0, neither: 3 }
p letter_case_count('') == { lowercase: 0, uppercase: 0, neither: 0 }
