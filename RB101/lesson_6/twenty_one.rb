require 'pry'

SUITS = %w[♥ ♠ ♦ ♣]
CARDS = %w[2 3 4 5 6 7 8 9 10 J Q K A].product(SUITS).map(&:join)
FACE_VALUE = 10
ACE = 'A'
ACE_VALUE = 11
ACE_ALTERNATE_VALUE = 1
MAX_HAND_SUM = 21
PLAYER_NAMES = %w[Dealer Player]

def shuffle_cards
  deck = CARDS.map do |card|
    face = card[0..-2].to_i
    value = if face == 0
              card[0] == ACE ? ACE_VALUE : FACE_VALUE
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

def print_game_table(dlr_hand, plr_hand, dlr_total, plr_total, show_dlr=false)
  dealer_str = if show_dlr
                 show_hand(dlr_hand, true) + " = #{dlr_total}"
               else
                 show_hand(dlr_hand)
               end

  player_str = show_hand(plr_hand, true) + " = #{plr_total}"

  player_str << ' *BUST*' if bust?(plr_total)
  dealer_str << ' *BUST*' if bust?(dlr_total)

  system('clear') || system('cls')
  puts <<~MSG
    ==== Welcome to Twenty-One! =====

    Dealer has: #{dealer_str}
    Player has: #{player_str}
    ---------------------------------
    Press 'h' to Hit, or 's' to Stay.
  MSG
end

def bust?(total)
  total > MAX_HAND_SUM
end

def determine_winner(dlr_total, plr_total)
  if bust?(plr_total)
    PLAYER_NAMES[0]
  elsif bust?(dlr_total)
    PLAYER_NAMES[1]
  else
    compare = [dlr_total, plr_total]
    return "Tie" if compare[0] == compare[1]

    PLAYER_NAMES[compare.index(compare.max)]
  end
end

def play_again?
  puts 'Would you like to play again? (y or n)'
  print '=> '
  true if gets[0].downcase == 'y'
end

def update_total(total, hand)
  if hand.any? { |card| card[:face][0] == ACE }
    hand_total(hand)
  else
    total + hand.last[:value]
  end
end

deck = shuffle_cards

loop do
  dealer_hand = deal_cards(deck, 2)
  player_hand = deal_cards(deck, 2)
  dlr_total = hand_total(dealer_hand)
  plr_total = hand_total(player_hand)

  # Players turn
  loop do
    print_game_table(dealer_hand, player_hand, dlr_total, plr_total)
    choice = ''
    loop do
      print "=> "
      choice = gets.chomp.downcase
      break if %w[h s].include? choice[0]

      puts "Incorrect selection. Please try again."
    end

    if choice == 'h'
      player_hand += deal_cards(deck) 
      plr_total = update_total(plr_total, player_hand)
    end
    break if choice == 's' || bust?(plr_total)
  end

  # Dealers turn
  unless bust?(plr_total)
    until dlr_total >= 17
      dealer_hand += deal_cards(deck)
      dlr_total = update_total(dlr_total, dealer_hand)
    end
  end

  winner = determine_winner(dlr_total, plr_total)

  print_game_table(dealer_hand, player_hand, dlr_total, plr_total, true)
  puts "\nThe winner is... #{winner}!!!"
  puts ''
  break unless play_again?
end

puts "\nThank you for playing Twenty-One. Goodbye!"
