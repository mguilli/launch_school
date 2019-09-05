def fizzbuzz(first, last)
  sequence = (first..last).map do |num|
    case
    when num % 15 == 0 then 'FizzBuzz'
    when num % 3 == 0 then 'Fizz'
    when num % 5 == 0 then 'Buzz'
    else num
    end
  end
  puts sequence.join ', '
end

fizzbuzz(1, 15) # -> 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz
