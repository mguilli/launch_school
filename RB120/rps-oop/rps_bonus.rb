require 'pry' # TODO Delete
class Move
  attr_reader :value
  VALUES = %w(rock paper scissors)

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    rock? && other_move.scissors? ||
      paper? && other_move.rock? ||
      scissors? && other_move.paper?
  end

  def <(other_move)
    rock? && other_move.paper? ||
      paper? && other_move.scissors? ||
      scissors? && other_move.rock?
  end
end

class Player
  attr_accessor :move, :name
  attr_reader :score

  def initialize
    set_name
    @score = 0
  end

  def award_point
    @score += 1
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts 'What is your name?'
      n = gets.chomp
      break unless n.empty?
      puts 'Please enter a valid name.'
    end

    self.name = n
  end

  def choose
    choice = nil

    loop do
      puts 'Please choose rock, paper, or scissors:'
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts 'Invalid choice.'
    end

    self.move = Move.new choice
  end
end

class Computer < Player
  def set_name
    self.name = %w(R2D2 Hal Chappie Sonny Number\ 5).sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

# Game orchestration engine
class RPSGame
  attr_accessor :human, :computer
  SCORE_LIMIT = 3

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts 'Welcome to Rock, Paper, Scissors!'
  end

  def display_goodbye_message
    puts 'Thanks for playing RPS!'
  end

  def display_moves
    puts "#{human.name} chose #{human.move.value}"
    puts "#{computer.name} chose #{computer.move.value}"
  end

  def determine_winner
    if human.move > computer.move
      human
    elsif human.move < computer.move
      computer
    end
  end

  def display_winner(winner)
    if winner
      puts "#{winner.name} won!"
    else
      puts "It's a tie!"
    end

    puts "[#{human.name}, #{computer.name}] = " \
         "[#{human.score}, #{computer.score}]"
  end

  def play_again?
    answer = nil

    loop do
      puts 'Would you like to play again? (y/n)?'
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts 'Invalid choice.'
    end

    answer == 'y'
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_moves
      winner = determine_winner
      winner.award_point if winner
      display_winner(winner)
      top_score = [human.score, computer.score].max
      break unless top_score < SCORE_LIMIT && play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
