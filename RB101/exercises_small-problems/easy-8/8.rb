LETTERS = [*'a'..'z'] - %w[a e i o u]
def double_consonants(str)
  # str.gsub(/([b-z&&[^aeiou]])/i, '\1\1')
  str.chars.map { |c| LETTERS.include?(c.downcase) ? c * 2 : c }.join
end

p double_consonants('String')
p double_consonants('String') == "SSttrrinngg"
p double_consonants("Hello-World!") == "HHellllo-WWorrlldd!"
p double_consonants("July 4th") == "JJullyy 4tthh"
p double_consonants('') == ""
p double_consonants('Ape') == "Appe"
