# Rock Paper Scissors game

VALID_CHOICES = %w[rock paper scissors].freeze

def prompt(message)
  puts "=> #{message}"
end

def player_wins?(player, computer)
  x, y = [player, computer].map { |c| VALID_CHOICES.index(c) }
  (x > y) ^ ((x - y).abs == 2)
end

def display_results(player, computer)
  return prompt('It is a tie!') if player == computer

  prompt(player_wins?(player, computer) ? 'You won!' : 'Computer won. :(')
end

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = gets.chomp

    break if VALID_CHOICES.include?(choice)

    prompt("That's not a valid choice")
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{choice}; Computer chose #{computer_choice}")

  display_results(choice, computer_choice)

  prompt('Do you want to play again?')
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt('Thank you for playing. Good bye!')
