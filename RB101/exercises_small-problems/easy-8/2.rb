# Mad libs
keys = %i[noun verb adjective adverb]
madlib = {}

keys.each do |key|
  article = key.match?(/^[aeiou]/) ? 'an' : 'a'

  print "Enter #{article} #{key}: "
  word = gets.chomp

  madlib[key] = word
end

sentence =  "Oh my! Yesterday, I saw this %{adjective} %{noun} " \
     "%{adverb} %{verb} down the street, as if it was just " \
     "a normal day!"
puts format(sentence, madlib)
