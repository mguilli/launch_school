require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def get_square_at(key)
    @squares[key]
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!detect_winner
  end

  def winning_line?(line)
    markers = @squares.values_at(*line).map(&:marker)
    markers.all?(TTTGame::HUMAN_MARKER) ||
      markers.all?(TTTGame::COMPUTER_MARKER)
  end

  # return winning marker or nil
  def detect_winner
    winning_line = WINNING_LINES.find { |line| winning_line?(line) }
    @squares[winning_line.first].marker if winning_line
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
    system 'clear'
    puts 'Welcome to Tic Tac Toe!'
    puts ''
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe! Goodbye!'
  end

  def display_board(clear_screen = true)
    system 'clear' if clear_screen
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

    case board.detect_winner
    when HUMAN_MARKER
      puts "You won!"
    when COMPUTER_MARKER
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer

      puts "Invalid selection."
    end

    answer == 'y'
  end

  def play
    display_welcome_message

    loop do
      display_board(false)

      loop do
        human_moves
        break if board.someone_won? || board.full?
        
        computer_moves
        break if board.someone_won? || board.full?
        display_board
      end

      display_result
      break unless play_again?

      board.reset
      system 'clear'
      puts "Let's play again!"
      puts ''
    end

    display_goodbye_message
  end
end

game = TTTGame.new
game.play
