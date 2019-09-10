def triangle(*angles)
  return :invalid unless angles.sum == 180 && angles.all?(&:positive?)

  case
  when angles.any?(90) then :right
  when angles.any? { |angle| angle > 90 } then :obtuse
  else :acute
  end
end

p triangle(60, 70, 50) == :acute
p triangle(30, 90, 60) == :right
p triangle(120, 50, 10) == :obtuse
p triangle(0, 90, 90) == :invalid
p triangle(50, 50, 50) == :invalid
