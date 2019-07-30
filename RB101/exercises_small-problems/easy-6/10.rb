def triangle(n)
  1.step(n) { |i| puts ('*' * i).rjust(n) }
end

triangle 5
triangle 9
