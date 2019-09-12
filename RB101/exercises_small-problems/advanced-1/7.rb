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

p merge([9,5], [7,1])
p merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]
p merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
p merge([], [1, 4, 5]) == [1, 4, 5]
p merge([1, 4, 5], []) == [1, 4, 5]

p merge([1,5], [2,3,4,6]) == [1,2,3,4,5,6]
