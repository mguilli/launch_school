def letter_case_count(str)
  lower = str.count 'a-z'
  upper = str.count 'A-Z'
  neither = str.count '^a-zA-Z'
  [lower, upper, neither]
end

def prettify(*args)
  args.map do |arg|
    arg = arg.to_i == arg ? arg.to_i : arg.round(2)
  end
end

def calculate_percentages(str)
end

def letter_percentages(str)
  total_chars = str.size
  lower, upper, neither = 
    letter_case_count(str).map { |count| 100 * (count / total_chars.to_f) }

  lower, upper, neither = prettify(lower, upper, neither)
  {lowercase: lower, uppercase: upper, neither: neither}
end

p letter_percentages('abCdef 123')
p letter_percentages('abCdef 123') == { lowercase: 50, uppercase: 10, neither: 40 }
p letter_percentages('AbCd +Ef')
p letter_percentages('AbCd +Ef') == { lowercase: 37.5, uppercase: 37.5, neither: 25 }
p letter_percentages('123') == { lowercase: 0, uppercase: 0, neither: 100 }
p letter_percentages('abcdefGHI')
