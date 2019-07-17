# Method 1
def oddities(array)
  array.select.with_index { |_, i| i.even? }
end

puts oddities([2, 3, 4, 5, 6]) == [2, 4, 6]
puts oddities([1, 2, 3, 4, 5, 6]) == [1, 3, 5]
puts oddities(['abc', 'def']) == ['abc']
puts oddities([123]) == [123]
puts oddities([]) == []

# Further exploration

# Companion method
def eventies(array)
  (0...array.size).select(&:odd?).map { |i| array[i] }
end

puts eventies([*1..10]) == [2, 4, 6, 8, 10]
puts eventies(%w[a b c d e f]) == %w[b d f]

# Method 2
def oddities(array)
  0.step(array.size - 1, 2).map { |i| array[i] }
end

puts oddities([*1..10]) == [1, 3, 5, 7, 9]
puts oddities(%w[a b c d e f]) == %w[a c e]

# Method to return both odd and even elements
def every_other(array)
  array.each_slice(2).to_a.transpose
end

puts every_other([*1..10]) == [[1, 3, 5, 7, 9], [2, 4, 6, 8, 10]]
puts every_other(%w[a b c d e f]) == [%w[a c e], %w[b d f]]