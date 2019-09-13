def neutralize(sentence)
  words = sentence.split(' ')
  positive_words = []
  words.each do |word|
    # Modifying `words` while iterating causes unpredicted behavior
    # words.delete(word) if negative?(word)
    positive_words << word unless negative?(word)
  end

  positive_words.join(' ')
end

def negative?(word)
  [ 'dull',
    'boring',
    'annoying',
    'chaotic'
  ].include?(word)
end

puts neutralize('These dull boring cards are part of a chaotic board game.')
# Expected: These cards are part of a board game.
# Actual: These boring cards are part of a board game.