class Player
  attr_accessor :move, :name

  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
    set_name
  end

  def set_name
    self.name = if human?
                  n = ''
                  loop do
                    puts 'What is your name?'
                    n = gets.chomp
                    break unless n.empty?
                    puts 'Please enter a valid name.'
                  end

                  n
                else
                  %w(RsDs Hal Chappie Sonny Number\ 5).sample
                end
  end

  def choose
    if human?
      choice = nil

      loop do
        puts 'Please choose rock, paper, or scissors:'
        choice = gets.chomp
        break if %w(rock paper scissors).include? choice
        puts 'Invalid choice.'
      end

      self.move = choice
    else
      self.move = %w(rock paper scissors).sample
    end
  end

  def human?
    @player_type == :human
  end
end

# Game orchestration engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new(:computer)
  end

  def display_welcome_message
    puts 'Welcome to Rock, Paper, Scissors!'
  end

  def display_goodbye_message
    puts 'Thanks for playing RPS!'
  end

  def display_winner
    puts "You chose #{human.move}"
    puts "The computer chose #{computer.move}"

    case human.move
    when 'rock'
      puts "It's a tie!" if computer.move == 'rock'
      puts 'You won!' if computer.move == 'scissors'
      puts 'Computer won!' if computer.move == 'paper'
    when 'paper'
      puts "It's a tie!" if computer.move == 'paper'
      puts 'You won!' if computer.move == 'rock'
      puts 'Computer won!' if computer.move == 'scissors'
    when 'scissors'
      puts "It's a tie!" if computer.move == 'scissors'
      puts 'You won!' if computer.move == 'paper'
      puts 'Computer won!' if computer.move == 'rock'
    end
  end

  def play_again?
    answer = nil

    loop do
      puts 'Would you like to play again? (y/n)?'
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts 'Invalid choice.'
    end

    answer == 'y'
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
