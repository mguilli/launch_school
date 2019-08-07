# Using the each method, write some code to output all of the vowels from the strings.

hsh = {
  first: ['the', 'quick'],
  second: ['brown', 'fox'],
  third: ['jumped'],
  fourth: ['over', 'the', 'lazy', 'dog']
}

hsh.each do |_, val|
  val.join.scan(/[aeiou]/i).each { |vowel| puts vowel }
end
