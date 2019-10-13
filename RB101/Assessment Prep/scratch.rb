arr = (0..5).to_a
pairs = []
arr.each_with_index do |val, i|
  (i+1...arr.size).each do |j|
    pairs << [val, arr[j]]
  end
end

p pairs
p arr.combination(2).to_a
p pairs == arr.combination(2).to_a
