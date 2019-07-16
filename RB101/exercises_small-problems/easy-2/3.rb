print 'What is the bill amount? >> '
bill = gets.chomp.to_f
print 'What is the tip percentge? >> '
rate = gets.chomp.to_f

tip = bill * rate / 100
total = bill + tip

format_str = '$%.2f'
puts "The tip is: #{format_str % tip}"
puts "The total is: #{format_str % total}"

