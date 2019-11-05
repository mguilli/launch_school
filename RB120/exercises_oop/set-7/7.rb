require 'pry'

class GuessingGame
  GUESS_MSG = {
    match: "That's the number!",
    low:   'Your number is too low.',
    high:  'Your number is too high.'
  }.freeze

  WIN_OR_LOSE = {
    win: 'You won!',
    lose: 'You have no more guesses. You lost!'
  }.freeze

  def initialize(min, max)
    @range = min..max
    @max_guesses = Math.log2(@range.size).to_i + 1
  end

  def play
    prepare_game

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

  def prepare_game
    @remaining = @max_guesses
    @winning_number = rand(@range)
  end

  def show_remaining_guesses
    guess_str = @remaining == 1 ? 'guess' : 'guesses'
    puts "You have #{@remaining} #{guess_str} remaining.\n"
  end

  def prompt_for_guess
    choice = nil
    loop do
      print "Enter a number between #{@range.first} and #{@range.last}: "
      choice = gets.chomp.to_i
      break if @range.cover? choice

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
game = GuessingGame.new(5, 205)
game.play
puts '--------'
game.play
