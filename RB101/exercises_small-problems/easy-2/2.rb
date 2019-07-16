# 1 square meter == 10.7639 square feet
SQ_METERS_TO_SQ_FEET = 10.7639

def calculate_area(l, w)
  sq_meters = l * w
  sq_feet = sq_meters * SQ_METERS_TO_SQ_FEET

  [sq_meters, sq_feet].map { |x| x.round(2) }
end

puts "Let's calculate the area of a room!"
puts 'Please input integers only.'
print 'Enter the length of the room in meters: '
length = gets.chomp.to_f
print 'Enter the width of the room in meters: '
width = gets.chomp.to_f

meters, feet = calculate_area(length, width)
puts "The area of the room in square meters is: #{meters}"
puts "The area of the room in square feet is: #{feet}"
