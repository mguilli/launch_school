def my_method(array)
  if array.empty?
    []
  elsif array.size > 1
    # elseif did not originally have a condition
    array.map do |value|
      value * value
    end
  else
    [7 * array.first]
  end
end

p my_method([]) # []
p my_method([3]) # [21]
p my_method([3, 4]) # [9, 16]
p my_method([5, 6, 7]) # [25, 36, 49]


def test(n)
  if n.positive?
    'positive'
  elsif # looks to next line. uses 'zero' as conditional, which is 'true'
        # however, there is no code to execute between 'zero' and the else
        # statement, so the if/elsif/else shortcircuits to always return nil
        # unless n is positive
    'zero'
  else
    'negative'
  end
end
