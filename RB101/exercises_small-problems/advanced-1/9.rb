def egyptian(rational)
  denominators = []

  (1..).each do |denom|
    next if Rational(1, denom) > rational

    denominators << denom
    rational -= Rational(1, denom)
    break if rational.zero?
  end

  denominators
end

def unegyptian(denominators)
  denominators.sum { |denom| Rational(1, denom) }
end

# def egyptian_loop(rational)
#   result = []
#   denominator = 1
#   while rational > 0
#     if rational >= Rational(1, denominator)
#       result << denominator
#       rational -= Rational(1, denominator)
#     end
#     denominator += 1
#   end
#   result
# end

p egyptian(Rational(2, 1)) == [1, 2, 3, 6]
p egyptian(Rational(137, 60)) == [1, 2, 3, 4, 5]
p egyptian(Rational(3, 1)) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 230, 57960]

p unegyptian(egyptian(Rational(1, 2))) == Rational(1, 2)
p unegyptian(egyptian(Rational(3, 4))) == Rational(3, 4)
p unegyptian(egyptian(Rational(39, 20))) == Rational(39, 20)
p unegyptian(egyptian(Rational(127, 130))) == Rational(127, 130)
p unegyptian(egyptian(Rational(5, 7))) == Rational(5, 7)
p unegyptian(egyptian(Rational(1, 1))) == Rational(1, 1)
p unegyptian(egyptian(Rational(2, 1))) == Rational(2, 1)
p unegyptian(egyptian(Rational(3, 1))) == Rational(3, 1)
