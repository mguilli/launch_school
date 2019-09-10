def triangle(*sides)
  return :invalid unless sides.all?(&:positive?) && sides.min(2).sum > sides.max

  case sides.uniq.size
  when 1 then :equilateral
  when 2 then :isosceles
  else :scalene
  end
end

p triangle(3, 3, 3) == :equilateral
p triangle(3, 3, 1.5) == :isosceles
p triangle(3, 4, 5) == :scalene
p triangle(0, 3, 3) == :invalid
p triangle(3, 1, 1) == :invalid
