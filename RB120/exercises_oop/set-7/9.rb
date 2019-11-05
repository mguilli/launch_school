class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    shuffle_cards
  end

  def draw
    shuffle_cards if @cards.empty?
    @cards.pop
  end

  private

  def shuffle_cards
    @cards = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end

    @cards.shuffle!
  end
end

class Card
  include Comparable
  attr_reader :rank, :suit

  FACE_VALUES = %w(Jack Queen King Ace).zip(11..14).to_h

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    FACE_VALUES[rank] || rank
  end

  def <=>(other)
    value <=> other.value
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
