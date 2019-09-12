def merge(a, b)
  return [a, b].max_by(&:size) if [a, b].any?(&:empty?)

  result = []
  idx_a = idx_b = 0

  loop do
    if a[idx_a] < b[idx_b]
      result << a[idx_a]
      idx_a += 1
    else
      result << b[idx_b]
      idx_b += 1
    end
    break unless idx_a < a.size && idx_b < b.size
  end

  result += [a[idx_a..-1], b[idx_b..-1]].max_by(&:size)
end

# def merge_sort(array)
#   return array if array.size == 1

#   middle = array.size / 2
#   first_half = merge_sort(array[0...middle])
#   second_half = merge_sort(array[middle..-1])

#   merge(first_half, second_half)
# end

def merge_sort(array)
  array = array.map { |n| [n] }
  while array[1]
    array = array.each_slice(2).map do |x, y|
      x ||= []
      y ||= []
      merge(x, y)
    end
  end
  array.flatten
end

p merge([9,5],[7,1])
p merge_sort([9, 5, 7, 1])
p merge_sort([9, 5, 7, 1]) == [1, 5, 7, 9]
p merge_sort([5, 3]) == [3, 5]
p merge_sort([6, 2, 7, 1, 4]) == [1, 2, 4, 6, 7]
p merge_sort(%w(Sue Pete Alice Tyler Rachel Kim Bonnie)) == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
p merge_sort([7, 3, 9, 15, 23, 1, 6, 51, 22, 37, 54, 43, 5, 25, 35, 18, 46]) == [1, 3, 5, 6, 7, 9, 15, 18, 22, 23, 25, 35, 37, 43, 46, 51, 54]
