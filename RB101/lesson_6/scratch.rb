line = [1, 2, 3]
count = line.count do |square|
  square < 4
end
count == 3
