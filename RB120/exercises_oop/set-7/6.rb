require 'pry'

class GuessingGame
  MAX_GUESSES = 7
  RANGE = 1..100

  GUESS_MSG = {
    match: "That's the number!",
    low:   'Your number is too low.',
    high:  'Your number is too high.'
  }.freeze

  WIN_OR_LOSE = {
    win: 'You won!',
    lose: 'You have no more guesses. You lost!'
  }.freeze

  def play
    initialize_game

    until @remaining == 0 || won?
      show_remaining_guesses
      prompt_for_guess
      show_result
      @remaining -= 1
    end

    puts won? ? 'You won!' : 'You have no more guesses. You lost!'
  end

  private

  def won?
    @guess == @winning_number
  end

  def initialize_game
    @remaining = MAX_GUESSES
    @winning_number = rand(RANGE)
  end

  def show_remaining_guesses
    guess_str = @remaining == 1 ? 'guess' : 'guesses'
    puts "You have #{@remaining} #{guess_str} remaining.\n"
  end

  def prompt_for_guess
    choice = nil
    loop do
      print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
      choice = gets.chomp.to_i
      break if RANGE.cover? choice

      print 'Invalid guess. '
    end

    @guess = choice
  end

  def show_result
    case @guess
    when @winning_number then puts GUESS_MSG[:match]
    when (1...@winning_number) then puts GUESS_MSG[:low]
    else puts GUESS_MSG[:high]
    end

    puts ''
  end
end

system 'clear'
game = GuessingGame.new
game.play
puts '--------'
game.play
