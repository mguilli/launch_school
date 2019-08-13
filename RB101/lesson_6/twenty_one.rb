require 'pry'

SUITS = %w[♥ ♠ ♦ ♣]
CARDS = %w[2 3 4 5 6 7 8 9 10 J Q K A].product(SUITS).map(&:join)
FACE_VALUE = 10
ACE_VALUE = 11
ACE_ALTERNATE_VALUE = 1
MAX_HAND_SUM = 21
PLAYER_NAMES = %w[Dealer Player]

def shuffle_cards
  deck = CARDS.map do |card|
    face = card[0..-2].to_i
    value = if face == 0
              card[0] == 'A' ? ACE_VALUE : FACE_VALUE
            else
              face
            end

    {face: card, value: value}
  end

  deck.shuffle
end

def deal_cards(deck, number_cards=1)
  deck.unshift(shuffle_cards).flatten! if deck.size < number_cards
  cards = []
  number_cards.times { cards << deck.pop }
  cards
end

def show_hand(hand, show_all=false)
  if show_all
    "[ #{hand.map { |card| card[:face] }.join(', ')} ]"
  else
    "[ #{hand[0][:face]}, Unknown ]"
  end
end

def hand_total(hand)
  sum = hand.sum { |card| card[:value] }

  if sum > MAX_HAND_SUM
    number_aces = hand.count { |card| card[:value] == ACE_VALUE }

    number_aces.times do
      sum -= ACE_VALUE - ACE_ALTERNATE_VALUE if sum > MAX_HAND_SUM
    end
  end

  sum
end

def print_game_table(dealer_hand, player_hand, show_dealers_hand=false)
  dealer_str = if show_dealers_hand
                 show_hand(dealer_hand, true) + " = #{hand_total(dealer_hand)}"
               else
                 show_hand(dealer_hand)
               end

  player_str = show_hand(player_hand, true) + " = #{hand_total(player_hand)}"

  player_str << ' *BUST*' if bust?(player_hand)
  dealer_str << ' *BUST*' if bust?(dealer_hand)

  system('clear') || system('cls')
  puts <<~MSG
    ==== Welcome to Twenty-One! =====

    Dealer has: #{dealer_str}
    Player has: #{player_str}
    ---------------------------------
    Press 'h' to Hit, or 's' to Stay.
  MSG
end

def bust?(hand)
  hand_total(hand) > MAX_HAND_SUM
end

def determine_winner(dealer_hand, player_hand)
  if bust?(player_hand)
    PLAYER_NAMES[0]
  elsif bust?(dealer_hand)
    PLAYER_NAMES[1]
  else
    compare = [hand_total(dealer_hand), hand_total(player_hand)]
    return "Tie" if compare[0] == compare[1]

    PLAYER_NAMES[compare.index(compare.max)]
  end
end

def play_again?
  puts 'Would you like to play again? (y or n)'
  print '=> '
  true if gets[0].downcase == 'y'
end

deck = shuffle_cards

loop do
  dealer_hand = deal_cards(deck, 2)
  player_hand = deal_cards(deck, 2)

  # Players turn
  loop do
    print_game_table(dealer_hand, player_hand)
    choice = ''
    loop do
      print "=> "
      choice = gets.chomp.downcase
      break if %w[h s].include? choice[0]

      puts "Incorrect selection. Please try again."
    end
    player_hand += deal_cards(deck) if choice == 'h'
    break if choice == 's' || bust?(player_hand)
  end

  # Dealers turn
  unless bust?(player_hand)
    until hand_total(dealer_hand) >= 17
      dealer_hand += deal_cards(deck)
    end
  end

  winner = determine_winner(dealer_hand, player_hand)

  print_game_table(dealer_hand, player_hand, true)
  puts "\nThe winner is... #{winner}!!!"
  puts ''
  break unless play_again?
end

puts "\nThank you for playing Twenty-One. Goodbye!"
