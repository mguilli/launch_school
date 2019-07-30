def swapcase(str)
  str.chars.map { |char| char =~ /[a-z]/ ? char.upcase : char.downcase }.join
end

p swapcase('CamelCase') == 'cAMELcASE'
p swapcase('Tonight on XYZ-TV') == 'tONIGHT ON xyz-tv'
