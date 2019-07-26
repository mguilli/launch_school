ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

p ages.values.sum
p ages.sum { |_, v| v}
p ages.sum(&:last)

sum = 0
ages.each_value { |v| sum += v}
p sum 
p ages.reduce(0) { |sum, (k, v)| sum + v }
