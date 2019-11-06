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

class PokerHand
  RESPONSES = {
    royal_flush?: 'Royal flush',
    straight_flush?: 'Straight flush',
    four_of_a_kind?: 'Four of a kind',
    full_house?: 'Full house',
    flush?: 'Flush',
    straight?: 'Straight',
    three_of_a_kind?: 'Three of a kind',
    two_pair?: 'Two pair',
    pair?: 'Pair',
    high?: 'High card'
  }

  def initialize(deck)
    @hand = []
    5.times { @hand << deck.draw }
  end

  def print
    puts @hand
  end

  def evaluate
    methods = RESPONSES.keys[0..-2]
    result = methods.find { |method| send method } || :high?
    RESPONSES[result]
  end

  private

  def royal_flush?
    straight_flush? && @hand.max.rank == 'Ace'
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    n_of_a_kind?(4)
  end

  def full_house?
    pair? && three_of_a_kind?
  end

  def flush?
    @hand.map(&:suit).uniq.size == 1
  end

  def straight?
    values = card_values
    (values.max - values.min) == 4 && values.uniq.size == 5
  end

  def three_of_a_kind?
    n_of_a_kind?(3)
  end

  def two_pair?
    values = card_values
    values.map { |v| values.count v }.count(2) == 4
  end

  def pair?
    n_of_a_kind?(2)
  end

  def card_values
    @hand.map(&:value)
  end

  def n_of_a_kind?(number_of_instances)
    values = card_values
    values.map! { |v| values.count v }
    values.include?(number_of_instances)
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'
