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

  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----|-----|-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----|-----|-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end

  def []=(square_number, marker)
    @squares[square_number].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  # return winning marker or nil
  def winning_marker
    winning_line = WINNING_LINES.find { |line| winning_line?(line) }
    @squares[winning_line.first].marker if winning_line
  end

  private

  def winning_line?(line)
    squares = @squares.values_at(*line)
    markers = squares.map(&:marker)
    squares.all?(&:marked?) && markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = ' '
  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  def marked?
    marker != INITIAL_MARKER
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

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    reset_players
  end

  def play
    display_welcome_message

    loop do
      display_board

      loop do
        # human_moves
        # break if board.someone_won? || board.full?

        # computer_moves
        # break if board.someone_won? || board.full?
        current_player_moves
        break if board.someone_won? || board.full?

        clear_screen_and_display_board if human_turn?
      end

      display_result
      break unless play_again?
      reset
    end

    display_goodbye_message
  end

  private

  attr_reader :board, :human, :computer, :current_player

  def clear_screen
    system 'clear'
  end

  def reset_players
    @current_player = [human, computer].cycle
  end

  def display_welcome_message
    clear_screen
    puts 'Welcome to Tic Tac Toe!'
    puts ''
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe! Goodbye!'
  end

  def clear_screen_and_display_board
    clear_screen
    display_board
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}"
    puts ""
    board.draw
    puts ""
  end

  def human_moves
    puts "Choose a square from #{board.unmarked_keys}: "
    square_number = nil
    loop do
      square_number = gets.chomp.to_i
      break if board.unmarked_keys.include? square_number

      puts 'Invalid choice selected.'
    end

    board[square_number] = human.marker
  end

  def computer_moves
    square_number = board.unmarked_keys.sample
    board[square_number] = computer.marker
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
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

  def reset
    board.reset
    reset_players
    clear_screen
    puts "Let's play again!"
    puts ''
  end

  def current_player_moves
    if current_player.next == human
      human_moves
    else
      computer_moves
    end
  end

  def human_turn?
    current_player.peek == human
  end
end

game = TTTGame.new
game.play
