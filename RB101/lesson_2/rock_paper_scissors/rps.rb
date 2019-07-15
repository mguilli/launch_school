# Rock Paper Scissors game

VALID_CHOICES = %w[rock paper scissors].freeze

def prompt(message)
  puts "=> #{message}"
end

def display_results(choice, computer_choice)
  return(prompt('It is a tie!')) if choice == computer_choice

  x, y = [choice, computer_choice].map { |c| VALID_CHOICES.index(c) }
  did_player_win = (x > y) ^ ((x - y).abs == 2)

  prompt(did_player_win ? 'You won!' : 'Computer won. :(')
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
