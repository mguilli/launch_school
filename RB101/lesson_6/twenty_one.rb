require 'pry'

SUITS = %w[♥ ♠ ♦ ♣]
CARDS = %w[2 3 4 5 6 7 8 9 10 J Q K A].product(SUITS).map(&:join)
FACE_VALUE = 10
ACE_VALUE = 11
ACE_ALTERNATE_VALUE = 1
MAX_HAND_SUM = 21

def shuffle_cards
  deck = CARDS.map do |card|
    face = card[0..-2].to_i
    if face == 0
      value = card[0] == 'A' ? ACE_VALUE : FACE_VALUE
    else
      value = face
    end

    {face: card, value: value}
  end

  deck.shuffle
end

def deal_cards(deck, number_cards=1)
  cards = []
  number_cards.times { cards << deck.pop }
  cards
end

def show_hand(hand, show_all=false)
  if show_all
    # str = '[ '
    # str << hand.map { |card| card[:face] }.join(', ')
    # str << ' ]'
    "[ #{hand.map { |card| card[:face] }.join(', ')} ]"
  else
    "[ #{hand[0][:face]}, Unknown ]"
  end
end

def hand_total(hand)
  sum = hand.sum { |card| card[:value] }

  unless sum <= MAX_HAND_SUM
    number_aces = hand.count { |card| card[:value] == ACE_VALUE }

    number_aces.times do
      sum -= ACE_VALUE - ACE_ALTERNATE_VALUE if sum > MAX_HAND_SUM
    end
  end

  sum
end

def print_game_table(dealer_hand, player_hand, show_dealers_hand=false)
  dealer_string = if show_dealers_hand
    "#{show_hand(dealer_hand, true)} = #{hand_total(dealer_hand)}"
  else
    "#{show_hand(dealer_hand)}"
  end

  system('clear') || system('cls')
  puts '==== Welcome to Twenty-One! ====='
  puts ''
  puts "Dealer has: #{dealer_string}"
  puts "Player has: #{show_hand(player_hand, true)} = #{hand_total(player_hand)}"
  puts '---------------------------------'
  puts "Press 'h' to Hit, or 's' to Stay."
end

def bust?(hand)
  hand_total(hand) > MAX_HAND_SUM
end

deck = shuffle_cards
dealer_hand = deal_cards(deck, 2)
player_hand = deal_cards(deck, 2)

# Player turn: hit or stay
# - repeat until bust or "stay"
loop do
  print_game_table(dealer_hand, player_hand)
  choice = ''
  loop do
    print "=> "
    choice = gets.chomp.downcase
    break if %w[h s].include? choice[0]

    puts "Incorrect selection. Please try again."
  end
  # If player bust, dealer wins.
  player_hand += deal_cards(deck) if choice == 'h'
  break if choice == 's' || bust?(player_hand)
end
# Dealer turn: hit or stay
# - repeat until total >= 17
# If dealer bust, player wins.
# Compare cards and declare winner.
print_game_table(dealer_hand, player_hand, true)
puts "\nThe winner is ....!!!"
puts ''
