require 'pry'

class Participant
  attr_reader :name

  def initialize(name)
    @hand = []
    @name = name
  end

  def hit(*cards)
    @hand += cards
  end
  
  def stay
    
  end
  
  def busted?
    
  end
  
  def total
    
  end

  def hand(hidden: false)
    first_card = hidden ? 'hidden' : @hand[0]
    "[#{first_card}, #{@hand[1..-1].join(', ')}]"
  end
end

class Player < Participant
end

class Dealer < Participant
end

class Deck
  CARDS = %w(2 3 4 5 6 7 8 9 10 J Q K A).product(%w(♥ ♠ ♦ ♣))

  def initialize
    shuffle
  end

  def shuffle
    cards = CARDS.map do |face, suit|
      Card.new(face, suit)
    end

    @cards = cards.shuffle
  end

  def deal
    @cards.pop
  end
end

class Card
  FACE_VALUE = 10
  ACE = 'A'
  ACE_VALUE = 11
  ACE_ALTERNATE_VALUE = 1

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
end

class Game
  def initialize
    @deck = Deck.new
    @player = Player.new('Player')
    @dealer = Dealer.new('Dealer')
  end

  def start
    show_welcome_message
    deal_cards
    show_initial_cards
    binding.pry
    player_turn
    dealer_turn
    show_result
  end

  private

  attr_accessor :player, :dealer, :deck

  def show_welcome_message
    puts 'Welcome to 21!'
  end

  def deal_cards
    2.times do
      player.hit(deck.deal)
      dealer.hit(deck.deal)
    end
  end

  def show_initial_cards
    # dealer.show_hand(hidden: true)
    # puts "Player: [#{player.hand.join(', ')}]"
    puts "#{dealer.name}: #{dealer.hand(hidden: true)}"
    puts "#{player.name}: #{player.hand}"
  end
end

Game.new.start
