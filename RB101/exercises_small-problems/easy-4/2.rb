def century(year)
  century = year / 100
  century += 1 if (year % 100).positive?

  century.to_s + century_suffix(century)
end

def century_suffix(century)
  humanize = %w[th st nd rd]

  # Stores the last digit if 0-9, or the last 2 digits if 11-19
  last_digits = century % 20

  humanize[last_digits] || humanize[0]
end

p century(2000) == '20th'
p century(2001) == '21st'
p century(1965) == '20th'
p century(256) == '3rd'
p century(5) == '1st'
p century(10103) == '102nd'
p century(1052) == '11th'
p century(1127) == '12th'
p century(11201) == '113th'
p century 10
