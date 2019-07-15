# Rock Paper Scissors game

VALID_CHOICES = %w[Rock Paper Scissors SPock Lizard].freeze

def prompt(message = nil)
  str = "=> #{message}"
  message ? puts(str) : print(str)
end

def player_wins?(player, computer)
  x, y = [player, computer].map { |c| VALID_CHOICES.index(c) }
  (x > y) ^ ((x - y).abs == 2 || (x - y).abs == 4)
end

def display_results(player, computer)
  return prompt('It is a tie!') if player == computer

  prompt(player_wins?(player, computer) ? 'You won!' : 'Computer won. :(')
end

loop do
  choice = ''
  loop do
    prompt("Enter all or part of name of a selection: #{VALID_CHOICES}")
    prompt('Selection is not Case Sensitve. Enter "sp" for spock)')
    prompt()
    choice = gets.chomp
    choice = VALID_CHOICES.find { |c| /^#{choice}/i === c }

    break if VALID_CHOICES.include?(choice)

    prompt("That's not a valid choice")
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{choice} | Computer chose: #{computer_choice}")

  display_results(choice, computer_choice)

  prompt('Do you want to play again?')
  prompt()
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt('Thank you for playing. Good bye!')
