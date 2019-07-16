print 'What is your name? '
name = gets.chomp

if name.end_with?('!')
  puts "HELLO #{name.chop.upcase}. WHY ARE WE SCREAMING?!?"
else
  puts "Hello, #{name}."
end