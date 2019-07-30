def multiply_all_pairs(arr1, arr2)
  arr1.reduce([]) { |result, v| result + arr2.map { |z| v * z } }.sort
  arr1.product(arr2).map { |x,y| x * y}.sort
end

p multiply_all_pairs([2, 4], [4, 3, 1, 2]) #== [2, 4, 4, 6, 8, 8, 12, 16]
p multiply_all_pairs([2, 4], [4, 3, 1, 2]) == [2, 4, 4, 6, 8, 8, 12, 16]
