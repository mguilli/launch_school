## Explore the problem before design
- Take time to explore the problem domain before settling on classes
- Use a [_spike_](https://en.wikipedia.org/wiki/Spike_(software_development)) to play around with the problem first

## Repetitive nouns in method names is a sign that you're missing a class
The following code would suggest that there needs to be a class named `Move` created to extract some logic to.

```ruby
human.make_move
computer.make_move

puts "Human move was #{format_move(human.move)}."
puts "Computer move was #{format_move(computer.move)}."

if compare_moves(human.move, computer.move) > 1
  puts "Human won!"
elsif compare_moves(human.move, computer.move) < 1
  puts "Computer won!"
else
  puts "It's a tie!"
end
```

All these references to "move" gives us a hint that we should be encapsulating the move into a custom move object, so that we can tell the object to "format yourself" or "compare yourself against another". Look at how the code could be possibly improved:

```ruby
human.move!
computer.move!

puts "Human move was #{human.move.display}."
puts "Computer move was #{computer.move.display}."

if human.move > computer.move
  puts "Human won!"
elsif human.move < computer.move
  puts "Computer won!"
else
  puts "It's a tie!"
end
```

## When naming methods, don't include the calss name.
`Player.info`, not `Player.player_info`

## Avoid long method invocation chains
`human.move.display.size` is not preferable, as it is harder to debug if something goes awry in the chain

Preferred:
```ruby
# if we determined that human.move could possible return nil
move = human.move
puts move.display.size if move
```

## Avoid design patterns for now
_"Premature optimization is the root of all evil"_

Don't worry about 'best practices' or 'design patterns' for now. Don't attempt to write overly clever code.
Will spedn the rest of career mastering design patterns and best practices.
