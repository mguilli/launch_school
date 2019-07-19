def swap(str)
  str.split.each { |word| word[0], word[-1] = word[-1], word[0] } * ' '
end

p swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
p swap('Abcde') == 'ebcdA'
p swap('a') == 'a'

str = 'hello there'
p swap(str)
p str
