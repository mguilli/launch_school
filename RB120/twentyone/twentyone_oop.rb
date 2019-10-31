class Participant
  MAX_HAND_SUM = 21
  attr_reader :name

  def initialize
    discard_hand
  end

  def draw_card(card)
    @hand << card
  end

  def busted?
    total > MAX_HAND_SUM
  end

  def total
    sum = @hand.sum(&:value)

    if sum > MAX_HAND_SUM
      number_aces = @hand.count(&:ace?)
      number_aces.times do
        sum -= Card::FACE_VALUE if sum > MAX_HAND_SUM
      end
    end

    sum
  end

  def show_hand(first_card_hidden = false)
    first_card = first_card_hidden ? 'hidden' : @hand.first
    cards_string = "[#{first_card}, #{@hand[1..-1].join(', ')}]"

    output = "#{name} has: #{cards_string}"
    output << " = #{total}" unless first_card_hidden
    output << '*BUST*' if busted?
    output
  end

  def discard_hand
    @hand = []
  end
end

class Player < Participant
  def choose_name
    puts "What is your name?"

    choice = nil
    loop do
      print '=> '
      choice = gets.chomp.strip.squeeze(' ')
      break if choice.match?(/^[[:alpha:]]+/) && choice.size <= 20

      puts Game::INVALID_INPUT + ' Name must start with a letter. '
    end

    @name = choice
  end
end

class Dealer < Participant
  def choose_name
    @name = %w(R2D2 Robocop SkyNet Hal Wall-E).sample
  end
end

class Deck
  CARDS = %w(2 3 4 5 6 7 8 9 10 J Q K A).product(%w(♥ ♠ ♦ ♣))

  def initialize
    shuffle!
  end

  def shuffle!
    cards = CARDS.map do |face, suit|
      Card.new(face, suit)
    end

    @cards = cards.shuffle
  end

  def deal_card
    shuffle! if @cards.empty?
    @cards.pop
  end
end

class Card
  FACE_VALUE = 10
  ACE = 'A'
  ACE_VALUE = 11

  attr_reader :value

  def initialize(face, suit)
    @face = face
    @suit = suit
    @value = case face
             when /\d+/ then face.to_i
             when ACE then ACE_VALUE
             else FACE_VALUE
             end
  end

  def to_s
    @face + @suit
  end

  def ace?
    @face == ACE
  end
end

class Game
  INVALID_INPUT = 'Invalid input. Please try again.'
  DEALER_STAYS = 17

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    show_welcome_message
    select_player_name

    loop do
      deal_starting_cards
      display_cards(hide_dealer_cards: true)
      player_turn
      dealer_turn unless player.busted?
      show_result
      break unless play_again?

      discard_player_cards
    end

    puts "Thanks for playing!"
  end

  private

  attr_accessor :player, :dealer, :deck

  def show_welcome_message
    system 'clear'
    puts '==== Welcome to Twenty-One! ====', "\n"
  end

  def select_player_name
    dealer.choose_name
    player.choose_name
  end

  def deal_starting_cards
    2.times do
      player.draw_card(deck.deal_card)
      dealer.draw_card(deck.deal_card)
    end
  end

  def display_cards(hide_dealer_cards: false)
    show_welcome_message
    puts dealer.show_hand(hide_dealer_cards)
    puts player.show_hand
    puts "--------------------------------"
  end

  def player_turn
    until player.busted?
      choice = nil
      loop do
        puts "\nPress 'h' to Hit, or 's' to Stay."
        print '=> '
        choice = gets.chomp
        break if %w(h s).include? choice

        puts INVALID_INPUT
      end
      return if choice == 's'

      player.draw_card(deck.deal_card)
      display_cards(hide_dealer_cards: true)
    end
  end

  def dealer_turn
    until dealer.busted? || dealer.total >= DEALER_STAYS
      dealer.draw_card(deck.deal_card)
    end
  end

  def winner
    if player.busted?
      dealer.name
    elsif dealer.busted?
      player.name
    else
      return 'Tie' if player.total == dealer.total

      [dealer, player].max_by(&:total).name
    end
  end

  def show_result
    display_cards
    puts "\nThe Winner is ... #{winner}!"
  end

  def play_again?
    puts 'Would you like to play again? (y/n)'

    choice = nil
    loop do
      print '=> '
      choice = gets.chomp
      break if %w(y n).include? choice

      puts INVALID_INPUT
    end

    choice == 'y'
  end

  def discard_player_cards
    player.discard_hand
    dealer.discard_hand
  end
end

Game.new.start
