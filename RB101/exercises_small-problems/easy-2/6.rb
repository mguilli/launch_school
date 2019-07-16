puts (1..99).select(&:odd?)
puts (1..99).sum([]) { |val| val.odd? ? [val] : [] }