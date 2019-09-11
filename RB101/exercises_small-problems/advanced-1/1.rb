REPLACEMENTS = {
  noun: %w[dog bunny moon map response stranger moment software river student],
  verb: %w[runs jumps swims flies loves feels dances shakes rushes tosses
    chooses stops shrugs],
    adjective:
    %w[nervous fuzzy famous lucky green hungry angry happy strange old used],
    adverb:
    %w[busily ferociously voluntarily helplessly briskly patiently truly
      frankly frequently fully zestily]
}.freeze

def madlibs
  text = File.read('./madlib.txt')

  text.gsub(/\<(.+?)\>/) do
    word = $1
    capitalized = word[0].upcase == word[0]
    substitute = REPLACEMENTS[word.downcase.to_sym].sample
    
    capitalized ? substitute.capitalize : substitute
  end
end

puts madlibs
