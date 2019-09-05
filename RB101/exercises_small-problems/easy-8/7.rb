def repeater(str)
  letters = str.chars
  letters.zip(letters).join
end

p repeater('Hello')
p repeater('Hello') == "HHeelllloo"
p repeater("Good job!") == "GGoooodd  jjoobb!!"
p repeater('') == ''
