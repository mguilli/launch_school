require 'pry'

class Board
  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def get_square_at(key)
    @squares[key]
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  # def empty_squares
  #   @squares.filter { |_, square| square.marker == INITIAL_MARKER }.keys
  # end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end
end

class Square
  INITIAL_MARKER = ' '
  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!'
    puts ''
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe! Goodbye!'
  end

  def display_board
    system 'clear'
    puts "You're a #{human.marker}. Computer is a #{computer.marker}"
    puts ""
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts "     |     |"
    puts "-----|-----|-----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts "     |     |"
    puts "-----|-----|-----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts "     |     |"
    puts ""
  end

  def human_moves
    puts "Choose a square from #{board.unmarked_keys}: "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include? square

      puts 'Invalid choice selected.'
    end

    board.set_square_at(square, human.marker)
  end

  def computer_moves
    choice = board.unmarked_keys.sample
    # binding.pry
    board.set_square_at(choice, computer.marker)
  end

  def display_result
    display_board
    puts "It's an outcome?"
  end

  def play
    display_welcome_message
    display_board

    loop do
      human_moves
      # break if someone_one? || board_full?
      break if board.full?
      
      computer_moves
      break if board.full?
      display_board
      # break
      # break if someone_one? || board_full?
    end

    display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
