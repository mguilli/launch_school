def cleanup(str)
  str.gsub(/[^a-z]+/i, ' ')
end

p cleanup("---what's my +*& line?") == ' what s my line '

# Further exploration
def cleanup2(str)
  letters = [*'a'..'z'] + [*'A'..'Z']
  result = ''

  str.chars.each do |c|
    if letters.include?(c)
      result << c
    else
      result << ' ' unless result[-1] == ' '
    end
  end

  result
end

p cleanup2("---what's my +*& line?") == ' what s my line '
