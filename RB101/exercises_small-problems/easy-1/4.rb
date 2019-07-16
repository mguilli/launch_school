# def count_occurrences(array)
#   array = array.map(&:downcase)
#   items = array.uniq.map { |x| [x, array.count(x)] }
#   items.each { |a, b| puts "#{a} => #{b}" }
# end

# Using a hash
def count_occurrences(array)
  counts = {}
  array = array.map(&:downcase)
  array.each { |elem| counts[elem] = array.count(elem) }
  counts.each { |key, val| puts "#{key} => #{val}" }
end

vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'Truck'
]

count_occurrences(vehicles)