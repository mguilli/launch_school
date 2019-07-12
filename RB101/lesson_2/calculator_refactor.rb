def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  num.to_f != 0
end

def get_number(str)
  num = nil

  loop do
    prompt("What is the #{str} number?")
    num = gets.chomp

    break(num.to_f) if valid_number?(num)

    prompt('Error. Please enter a valid number.')
  end
end

def operator_to_message(operator)
  %w[Adding Subtracting Multiplying Dividing][operator - 1]
end

operator_prompt = <<~MSG
  What operation would you like to perform?
    1 - Add
    2 - Subtract
    3 - Multiply
    4 - Divide
MSG

prompt('Welcome to Calculator!')

loop do
  num1 = get_number('first')
  num2 = get_number('second')

  prompt(operator_prompt)

  operator = 0
  loop do
    operator = gets.chomp.to_i

    break if (1..4).include?(operator)

    prompt('Please use a valid operation selection (1,2,3, or 4).')
  end

  prompt("#{operator_to_message(operator)} the two numbers...")

  result = case operator
           when 1
             num1 + num2
           when 2
             num1 - num2
           when 3
             num1 * num2
           when 4
             num1 / num2
           end

  prompt("Your result is: #{result}")

  prompt('Would you like to perform another calculation (y or n)?')
  decision = gets.chomp.downcase

  break(prompt('Program exited')) unless %w[y yes].include?(decision)
end
