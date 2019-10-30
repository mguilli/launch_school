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
  # rubocop:enable Metrics/AbcSize

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

  def square_number_to_win(marker)
    good_line = WINNING_LINES.find { |line| two_markers_in_line?(line, marker) }
    good_line&.find { |key| @squares[key].unmarked? }
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

  def two_markers_in_line?(line, marker)
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

class Player
  INVALID_SELECTION = "Invalid selection. Please try again."
  attr_reader :marker, :name, :score

  def initialize
    @score = 0
  end

  def increase_score_by(number_of_points)
    @score += number_of_points
  end
end

class HumanPlayer < Player
  def select_marker
    choice = nil

    loop do
      puts "Select any single character to use as a marker: "
      choice = gets.chomp
      break if choice.length == 1 && choice.match?(/\S/)

      puts INVALID_SELECTION
    end

    @marker = choice
  end

  def select_name
    choice = nil
    loop do
      puts "Select a name (no spaces allowed): "
      choice = gets.chomp
      break if choice.match?(/^\S+$/)

      puts INVALID_SELECTION
    end

    @name = choice
  end
end

class ComputerPlayer < Player
  COMPUTER_NAMES = %w(R2D2 Robocop SkyNet Hal Wall-E)
  MARKER_DEFAULTS = %w(O X)

  def select_marker(disallowed: nil)
    @marker = (MARKER_DEFAULTS - [disallowed]).first
  end

  def select_name(disallowed: nil)
    @name = (COMPUTER_NAMES - [disallowed]).sample
  end
end

class TTTGame
  FIRST_PLAYER = :choose # options = [:human, :computer, :choose]
  SCORE_TO_WIN = 2
  INVALID_SELECTION = 'Invalid selection. Please try again.'

  def initialize
    @board = Board.new
    @human = HumanPlayer.new
    @computer = ComputerPlayer.new
    @players = [human, computer]
  end

  def play
    display_welcome_message
    select_names_and_markers
    select_first_player
    play_again = nil
    welcome_display = true

    loop do
      clear_screen_and_display_board(welcome_display, play_again)

      players_take_turns(welcome_display, play_again)
      welcome_display = false

      award_point_to_winner
      display_winner_and_scores
      break unless !grand_winner && (play_again = play_again?)

      reset_board
    end

    display_goodbye_message
  end

  private

  attr_reader :board, :human, :computer, :current_player, :players

  def players_take_turns(welcome_display, play_again)
    loop do
      current_player_moves
      break if board.someone_won? || board.full?

      clear_screen_and_display_board(welcome_display, play_again)
      welcome_display = play_again = false
    end
  end

  def select_names_and_markers
    human.select_name
    computer.select_name(disallowed: human.name)
    human.select_marker
    computer.select_marker(disallowed: human.marker)
  end

  def select_first_player
    choice = nil
    options = { c: :computer, h: :human }

    if FIRST_PLAYER == :choose
      loop do
        puts "Choose who goes first (h = human, c = computer):"
        choice = gets.chomp.downcase.to_sym
        break if options.keys.include? choice

        puts INVALID_SELECTION
      end
    end

    @first_player = options[choice] || FIRST_PLAYER
    reset_turn_order
  end

  def reset_turn_order
    @current_player = players.cycle
    current_player.next if @first_player == :computer
  end

  def reset_board
    board.reset
    reset_turn_order
    clear_screen
    puts "Let's play again!"
    puts ''
  end

  def clear_screen
    system 'clear'
  end

  def clear_screen_and_display_board(welcome = false, play_msg = false)
    clear_screen
    display_welcome_message if welcome
    puts "Let's play again!", '' if play_msg
    display_board
  end

  def display_welcome_message
    clear_screen
    puts 'Welcome to Tic Tac Toe!'
    puts "Win #{SCORE_TO_WIN} games to be named Grand Winner."
    puts ''
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe! Goodbye!'
  end

  def display_board
    puts "#{human.name} is a #{human.marker}." \
         " #{computer.name} is a #{computer.marker}"
    puts ""
    board.draw
    puts ""
  end

  def display_grand_winner
    case grand_winner.marker
    when human.marker then puts "#{human.name} is the Grand Winner!"
    when computer.marker then puts "#{computer.name} is the Grand Winner!"
    end
  end

  def display_winner
    case board.winning_marker
    when human.marker
      puts "#{human.name} won!"
    when computer.marker
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_winner_and_scores
    clear_screen_and_display_board

    display_winner
    puts "Scores [#{human.name}, #{computer.name}] =" \
         " #{[human.score, computer.score]}"

    display_grand_winner if grand_winner
  end

  def human_turn?
    current_player.peek == human
  end

  def current_player_moves
    if current_player.next == human
      human_moves
    else
      computer_moves
    end
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

  def computer_moves
    square_number = middle_square ||
                    board.square_number_to_win(computer.marker) ||
                    board.square_number_to_win(human.marker) ||
                    board.unmarked_keys.sample
    board[square_number] = computer.marker
  end

  def middle_square
    board.unmarked_keys.find { |v| v == Board::MIDDLE_SQUARE }
  end

  def award_point_to_winner
    case board.winning_marker
    when human.marker then human.increase_score_by(1)
    when computer.marker then computer.increase_score_by(1)
    end
  end

  def grand_winner
    players.find { |player| player.score >= SCORE_TO_WIN }
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
end

game = TTTGame.new
game.play
