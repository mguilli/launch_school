print 'Please write word or multiple words: '
string = gets.chomp
count = string.count '^ '
puts "There are #{count} characters in \"#{string}\""