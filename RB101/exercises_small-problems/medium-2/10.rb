def sum_square_difference(n)
  integers = 1..n
  sum_square = integers.sum**2
  square_sum = integers.sum { |x| x**2 }

  sum_square - square_sum
end

def sum_square_difference_solution(n)
  sum = 0
  sum_of_squares = 0

  1.upto(n) do |value|
    sum += value
    sum_of_squares += value**2
  end

  sum**2 - sum_of_squares
end

require 'benchmark'
array = [*1..3000]

Benchmark.bm(9) do |x|
  x.report('mine:') do
    array.each { |n| sum_square_difference(n) }
  end

  x.report('solution: ') do
    array.each { |n| sum_square_difference_solution(n) }
  end
end