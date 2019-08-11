require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
SCORE_TO_WIN = 5
FIRST_PLAYER = 'choose' # valid options = ['choose', 'computer', 'player']
PLAYERS = %w[player computer]
WINNING_LINES = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
  [1, 4, 7],
  [2, 5, 8],
  [3, 6, 9],
  [1, 5, 9],
  [3, 5, 7]
]

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system('clear') || system('cls')
  puts "You're an #{PLAYER_MARKER}. Computer is an #{COMPUTER_MARKER}."
  puts ''
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ''
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  (1..9).map { |key| [key, INITIAL_MARKER] }.to_h
end

def empty_squares(brd)
  brd.keys.select { |key| brd[key] == INITIAL_MARKER }
end

def joinor(array, delimiter=', ', word='or')
  case array.size
  when (0..1) then array[0].to_s
  when 2 then array.join(" #{word} ")
  else
    suffix = delimiter + word + ' ' + array[-1].to_s
    array[0..-2].join(delimiter) + suffix
  end
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}): "
    square = gets.chomp.to_i
    break if empty_squares(brd).include? square

    prompt "Sorry, that's not a valid choice."
  end

  brd[square] = PLAYER_MARKER
end

def find_optimal_sq(brd, marker)
  threat_line = WINNING_LINES.find do |line|
    values = brd.values_at(*line)
    values.count(marker) == 2 && values.count(INITIAL_MARKER) == 1
  end

  # Return nil if no threat_line found
  threat_line.find { |square| brd[square] == INITIAL_MARKER } if threat_line
end

def computer_places_piece!(brd)
  square = find_optimal_sq(brd, COMPUTER_MARKER) ||
           find_optimal_sq(brd, PLAYER_MARKER) ||
           (5 if brd[5] == INITIAL_MARKER) ||
           empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def place_piece!(brd, player)
  case player
  when PLAYERS[0] then player_places_piece!(brd)
  when PLAYERS[1] then computer_places_piece!(brd)
  end
end

def alternate_player(current)
  (PLAYERS - [current]).first
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    return PLAYERS[0] if line.all? { |key| brd[key] == PLAYER_MARKER }
    return PLAYERS[1] if line.all? { |key| brd[key] == COMPUTER_MARKER }
  end
  nil
end

def someone_won?(brd)
  !!detect_winner(brd)
end

scores = {player: 0, computer: 0}
loop do
  board = initialize_board

  if PLAYERS.include? FIRST_PLAYER
    current_player = FIRST_PLAYER
  else
    loop do
      prompt "Please select the first player #{PLAYERS}:"
      current_player = gets.chomp
      break if PLAYERS.include? current_player

      prompt "Incorrect selection."
    end
  end

  loop do
    display_board(board)

    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    winner = detect_winner(board)
    scores[winner.downcase.to_sym] += 1
    prompt "#{winner} won!"
  else
    prompt "It's a tie!"
  end

  puts ''
  prompt "Score Total = (Player: #{scores[:player]},"\
         " Computer: #{scores[:computer]})"

  grand_winner = scores.find { |_, val| val >= SCORE_TO_WIN }
  if grand_winner
    break(prompt "#{grand_winner[0].capitalize} is the Grand Winner!")
  end

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe. Goodbye!"
