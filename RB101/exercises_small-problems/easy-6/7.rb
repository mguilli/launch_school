def halvsies(array)
  split = array.size / 2.0
  # split -= 1 if array.size.even?

  array.partition.with_index { |_v, i| i < split }
end

p halvsies([1, 2, 3, 4]) == [[1, 2], [3, 4]]
p halvsies([1, 5, 2, 4, 3]) == [[1, 5, 2], [4, 3]]
p halvsies([5]) == [[5], []]
p halvsies([]) == [[], []]
