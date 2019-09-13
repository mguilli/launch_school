def shout_out_to(name)
  # name.chars.each { |c| c.upcase! }
  # Array#each is called on the result of name.chars, which is an array of 
  # characters containing new string objects that are different from the 'nama'
  # string object. so while String.upcase! is destructive, it is affecting the 
  # elements of the array, and not the string `name`

  puts 'HEY ' + name.upcase
end

shout_out_to('you') # expected: 'HEY YOU'