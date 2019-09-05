def sum_of_sums(array)
  result = []
  array.each_index do |i|
    result << array[0..i].sum
  end
  result.sum

  1.upto(array.size).sum { |c| array[0,c].sum }

  result = 0
  array.each_index do |i|
    result += array[0..i].sum
  end
  result
end

p sum_of_sums([3, 5, 2]) == (3) + (3 + 5) + (3 + 5 + 2) # -> (21)
p sum_of_sums([1, 5, 7, 3]) == (1) + (1 + 5) + (1 + 5 + 7) + (1 + 5 + 7 + 3) # -> (36)
p sum_of_sums([4]) == 4
p sum_of_sums([1, 2, 3, 4, 5]) == 35
