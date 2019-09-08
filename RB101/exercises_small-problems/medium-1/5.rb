def triangle(n)
  char_counts = (1..n).step(2)
  char_counts.map { |count| ('*' * count).center(n) }
end

def arrow(n)
  triangle = triangle(n).map(&:strip)

  triangle.map do |line|
    line[1..-2] = ' ' * (line.size - 2) if line.size > 1
    line.center(n)
  end
end

def diamond(n, fill=true)
  top = fill ? triangle(n) : arrow(n)
  bottom = top.reverse.drop(1)

  puts top
  puts bottom
end

diamond(1)
diamond(3)
diamond(9)
diamond(1, false)
diamond(3, false)
diamond(9, false)
