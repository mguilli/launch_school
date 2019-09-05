def center_of(str)
  middle = str.size / 2
  str.size.even? ? str[middle - 1, 2] : str[middle]
end

p center_of('I love ruby') == 'e'
p center_of('Launch School') == ' '
p center_of('Launch') == 'un'
p center_of('Launchschool') == 'hs'
p center_of('x') == 'x'
