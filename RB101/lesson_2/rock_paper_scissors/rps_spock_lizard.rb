# Rock Paper Scissors game

VALID_CHOICES = %w[Rock Paper Scissors SPock Lizard].freeze
GRAND_WINNER_LIMIT = 5

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

def update_win_counts(player, computer, counter)
  return if player == computer

  player_wins?(player, computer) ? counter[0] += 1 : counter[1] += 1
end

win_counts = [0, 0]
loop do
  choice = ''
  loop do
    prompt("Enter all or part of name of a selection: #{VALID_CHOICES}")
    prompt('Selection is not Case Sensitve. Enter "sp" for spock)')
    prompt
    choice = gets.chomp
    choice = VALID_CHOICES.find { |c| /^#{choice}/i =~ c }

    break if VALID_CHOICES.include?(choice)

    prompt("That's not a valid choice")
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{choice} | Computer chose: #{computer_choice}")

  update_win_counts(choice, computer_choice, win_counts)
  display_results(choice, computer_choice)
  prompt("Player, Computer wins: #{win_counts}")
  break unless win_counts.max < GRAND_WINNER_LIMIT

  prompt('Do you want to play again?')
  prompt
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

index = win_counts.index(GRAND_WINNER_LIMIT) || 2
grand_winner = %w[Player Computer No\ one][index]
prompt("#{grand_winner} is the Grand Winner!!!")
prompt('Thank you for playing. Good bye!')
