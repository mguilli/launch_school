require 'pry'
# cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]
CARDS = [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace].freeze


# The same array 'cards' is used for eack key's value. Any time 'cards' array 
# is mutated, all the key's values in the hash will change
# deck = { :hearts   => cards,
#          :diamonds => cards,
#          :clubs    => cards,
#          :spades   => cards }
deck = { :hearts   => CARDS.dup,
         :diamonds => CARDS.dup,
         :clubs    => CARDS.dup,
         :spades   => CARDS.dup }

def score(card)
  case card
  when :ace   then 11
  when :king  then 10
  when :queen then 10
  when :jack  then 10
  else card
  end
end

# Pick one random card per suit

player_cards = []
deck.keys.each do |suit|
  # Assigns the array from 'cards' back to itself
  cards = deck[suit]
  cards.shuffle!
  # cards.pop will remove a card from all suits per line 3 comment
  player_cards << cards.pop
end

# Determine the score of the remaining cards in the deck

# `sum` is used internally. Variable name could be better
sum = deck.reduce(0) do |sum, (_, remaining_cards)|
  # Array.map returns a new array and does not change `remaining_cards` value
  # remaining_cards.map do |card|
  card_scores = remaining_cards.map do |card|
    score(card)
  end

  # `+=` operator unnecessary. `+`
  sum += card_scores.sum
end
# binding.pry
puts player_cards.sum { |card| score(card) }
puts sum

# Sum of all cards == 380