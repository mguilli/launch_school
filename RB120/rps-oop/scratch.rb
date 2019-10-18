VALUES = %w(rock paper scissors spock lizard)
outcomes = VALUES.product VALUES

def lesser(x,y)
  x, y = [x, y].map { |m| VALUES.index(m) }
  (x < y) ^ ((x - y).abs == 2 || (x - y).abs == 4)
end


outcomes.map! do |a, b|
  [a, b, lesser(a,b)]
end

outcomes.each {|o| p o }
