require 'pry' # TODO delete

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]
  MIDDLE_SQUARE = 5

  def initialize
    @squares = {}
    reset
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
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

  def available_options(delimiter: ', ', conjuntion: 'or')
    options = unmarked_keys

    case options.size
    when 0, 1 then options[0]
    when 2 then options.join(" #{conjuntion} ")
    else
      suffix = delimiter + conjuntion + ' ' + options[-1].to_s
      options[0..-2].join(delimiter) + suffix
    end
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def find_optimal_square_num(marker)
    optimal_line = WINNING_LINES.find { |line| two_in_row?(line, marker) }
    optimal_line&.find { |key| @squares[key].unmarked? } # if optimal_line
  end

  def winning_marker
    winning_line = WINNING_LINES.find { |line| winning_line?(line) }
    @squares[winning_line.first].marker if winning_line
  end

  private

  def get_squares_and_markers(line)
    squares = @squares.values_at(*line)
    markers = squares.map(&:marker)
    [squares, markers]
  end

  def two_in_row?(line, marker)
    squares, markers = get_squares_and_markers(line)
    squares.one?(&:unmarked?) && markers.count(marker) == 2
  end

  def winning_line?(line)
    squares, markers = get_squares_and_markers(line)
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

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_PLAYER = :choose # options = [:human, :computer, :choose]
  SCORE_TO_WIN = 5
  INVALID_SELECTION = 'Invalid selection. Please try again.'
  Player = Struct.new(:marker, :score)

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER, 0)
    @computer = Player.new(COMPUTER_MARKER, 0)
    @players = [human, computer]
    reset_turn_order
  end

  def play
    display_welcome_message
    select_first_player

    loop do
      display_board

      loop do
        current_player_moves
        break if board.someone_won? || board.full?

        clear_screen_and_display_board if human_turn?
      end

      award_point
      display_result
      break unless !grand_winner && play_again?
      reset_board
    end

    display_goodbye_message
  end

  private

  attr_reader :board, :human, :computer, :current_player, :players

  def clear_screen
    system 'clear'
  end

  def grand_winner
    players.find { |player| player.score >= SCORE_TO_WIN }
  end

  def reset_turn_order
    @current_player = players.cycle
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
    puts "Choose a square from #{board.available_options}: "
    square_number = nil
    loop do
      square_number = gets.chomp.to_i
      break if board.unmarked_keys.include? square_number

      puts INVALID_SELECTION
    end

    board[square_number] = human.marker
  end

  def can_win_on_next_move?(player)
    !!board.find_optimal_square_num(player.marker)
  end

  def middle_square_available?
    board.unmarked_keys.include?(Board::MIDDLE_SQUARE)
  end

  def computer_moves
    if middle_square_available?
      square_number = Board::MIDDLE_SQUARE
    elsif can_win_on_next_move?(computer)
      square_number = board.find_optimal_square_num(computer.marker)
    elsif can_win_on_next_move?(human)
      square_number = board.find_optimal_square_num(human.marker)
    else
      square_number = board.unmarked_keys.sample
    end
    board[square_number] = computer.marker
  end

  def award_point
    case board.winning_marker
    when HUMAN_MARKER then human.score += 1
    when COMPUTER_MARKER then computer.score += 1
    end
  end

  def display_grand_winner
    case grand_winner.marker
    when HUMAN_MARKER then puts "You are the Grand Winner!"
    when COMPUTER_MARKER then puts "Computer is the Grand Winner!"
    end
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
    puts "Scores [Human, Computer] = #{[human.score, computer.score]}"
    display_grand_winner if grand_winner
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer

      puts INVALID_SELECTION
    end

    answer == 'y'
  end

  def reset_board
    board.reset
    reset_turn_order
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

  def select_first_player
    choice = nil

    if FIRST_PLAYER == :choose
      loop do
        puts "Choose who goes first (h = human, c = computer):"
        choice = gets.chomp.downcase
        break(clear_screen) if %w(c h).include? choice

        puts INVALID_SELECTION
      end
    end

    current_player.next if FIRST_PLAYER == :computer || choice == 'c'
  end
end

game = TTTGame.new
game.play
