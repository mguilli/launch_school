# Given the following data structure and without modifying the original array, use the map method to return a new array identical in structure to the original but where the value of each integer is incremented by 1.

p arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

result = arr.map do |hash|
  hash.map { |key, val| [key, val += 1] }.to_h
end

p result
p arr
