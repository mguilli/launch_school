def bottom_rays(n)
  (0...n/2).map do |space_count|
    line = %w[* * *].join(' ' * space_count)
    line.center(n)
  end
end

def star(grid_size)
  bottom = bottom_rays(grid_size)
  top = bottom.reverse

  puts top
  puts '*' * grid_size
  puts bottom
end

star(7)
puts
star(9)
puts
star(11)
