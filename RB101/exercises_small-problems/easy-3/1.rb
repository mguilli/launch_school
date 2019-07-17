HUMANIZED = %w[1st 2nd 3rd 4th 5th last].freeze

array = []

6.times do |i|
  puts "==> Enter the #{HUMANIZED[i]} number:"
  array[i] = gets.chomp.to_i
end
last_number = array.pop

may_appear = array.include?(last_number) ? 'appears' : 'does not appear'

puts "The number #{last_number} #{may_appear} in #{array}."