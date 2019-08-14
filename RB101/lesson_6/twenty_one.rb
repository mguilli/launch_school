# Twenty-One: A blackjack implementation

SUITS = %w[♥ ♠ ♦ ♣]
CARDS = %w[2 3 4 5 6 7 8 9 10 J Q K A].product(SUITS).map(&:join)
FACE_VALUE = 10
ACE = 'A'
ACE_VALUE = 11
ACE_ALTERNATE_VALUE = 1
DEALER_STAYS = 17
MAX_HAND_SUM = 21
POINTS_TO_WIN = 5

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

def deal_cards!(deck, number_cards=1)
  deck.unshift(shuffle_cards).flatten! if deck.size < number_cards
  cards = []
  number_cards.times { cards << deck.pop }
  cards
end

def cards_string(hand, show_all=false)
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

def generate_dealer_string(show_dlr, dlr_hand, dlr_total)
  if show_dlr
    cards_string(dlr_hand, true) + " = #{dlr_total}"
  else
    cards_string(dlr_hand)
  end
end

def print_game_table(args, show_dlr=false, instructions=true)
  dlr_hand, plr_hand, dlr_total, plr_total, scores = args

  dealer_str = generate_dealer_string(show_dlr, dlr_hand, dlr_total)
  player_str = cards_string(plr_hand, true) + " = #{plr_total}"

  player_str << ' *BUST*' if bust?(plr_total)
  dealer_str << ' *BUST*' if bust?(dlr_total)

  system('clear') || system('cls')
  puts <<~MSG
    ==== Welcome to Twenty-One! =====

    Dealer has: #{dealer_str}
    Player has: #{player_str}
    ---------------------------------
    Games won (Dealer:Player) = #{scores[:dealer]}:#{scores[:player]}
  MSG
  puts "\nPress 'h' to Hit, or 's' to Stay." if instructions
end

def bust?(total)
  total > MAX_HAND_SUM
end

def update_scores!(scores, winner)
  scores[winner.downcase.to_sym] += 1 unless winner == "Tie"
end

def determine_winner(dlr_total, plr_total)
  player_names = %w[Dealer Player]

  if bust?(plr_total)
    player_names[0]
  elsif bust?(dlr_total)
    player_names[1]
  else
    compare = [dlr_total, plr_total]
    return "Tie" if compare[0] == compare[1]

    player_names[compare.index(compare.max)]
  end
end

def play_again?
  puts 'Would you like to play again? (y or n)'
  print '=> '
  true if gets[0].downcase == 'y'
end

def update_hand_total(total, hand)
  if hand.any? { |card| card[:face][0] == ACE }
    hand_total(hand)
  else
    total + hand.last[:value]
  end
end

def grand_winner(scores)
  # return string or nil
  result = scores.find { |_, val| val >= POINTS_TO_WIN }
  result[0].to_s.capitalize if result
end

deck = shuffle_cards
scores = {dealer: 0, player: 0}

loop do
  dealer_hand = deal_cards!(deck, 2)
  player_hand = deal_cards!(deck, 2)
  dlr_total = hand_total(dealer_hand)
  plr_total = hand_total(player_hand)

  # Players turn
  loop do
    print_game_table([dealer_hand, player_hand, dlr_total, plr_total, scores])
    choice = ''
    loop do
      print "=> "
      choice = gets.chomp.downcase
      break if %w[h s].include? choice[0]

      puts "Incorrect selection. Please try again."
    end

    if choice == 'h'
      player_hand += deal_cards!(deck)
      plr_total = update_hand_total(plr_total, player_hand)
    end
    break if choice == 's' || bust?(plr_total)
  end

  # Dealers turn if player did not bust
  unless bust?(plr_total)
    until dlr_total >= DEALER_STAYS
      dealer_hand += deal_cards!(deck)
      dlr_total = update_hand_total(dlr_total, dealer_hand)
    end
  end

  # Determine winner
  winner = determine_winner(dlr_total, plr_total)
  update_scores!(scores, winner)
  grand_winner = grand_winner(scores)
  if grand_winner
    winner = grand_winner
    msg = 'Grand '
  else
    msg = ''
  end

  args = [dealer_hand, player_hand, dlr_total, plr_total, scores]
  print_game_table(args, true, false)

  puts "\nThe #{msg}Winner is... #{winner}!!!"
  puts ''

  # Reset scores if there has been a grand winner
  scores.each_key { |key| scores[key] = 0 } if grand_winner

  break unless play_again?
end

puts "\nThank you for playing Twenty-One. Goodbye!"
