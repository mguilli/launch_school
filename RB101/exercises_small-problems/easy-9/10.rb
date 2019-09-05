def buy_fruit(array)
  array.flat_map { |fruit, count| [fruit] * count }
end

p buy_fruit([["apples", 3], ["orange", 1], ["bananas", 2]]) ==
  ["apples", "apples", "apples", "orange", "bananas","bananas"]
