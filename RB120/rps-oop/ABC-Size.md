## Assinment Branch Condition Size
```ruby
abc_size = Math.sqrt(a**2 + b**2 + c**2)
```
Where:
a = assignments,
b = branches (method calls),
c = conditions

- Assignment
  - `variable = some_expression`
  - `var += expression`
- Branches
  -
- Conditions
  - any point in the code where execution can take 2 or more different paths
  - any code that tests the truthiness of an expression to determine what the program should do

### Conditions count:
```ruby
if a == 1 # 1 condition
  do_this
elsif b == 2 || c.empty? # 2 conditions
  do_that
end
puts final_result
```
### Branches count
- `+`,`*`,`==`,`>`, etc are all method calls
- `puts` is a method call
- every reference to a getter or setter method in your class is a method call

```ruby
class Example
  attr_reader :something
  def initialize
    @something = [...]
  end
  def print_something
    if something.size == 0
      puts "something has just 1 item: #{something[0]}"
    elsif something.size == 1
      puts "something has 2 items: #{something[0]} #{something[1]}"
    else
      puts "something has #{something.size} items: #{something.join(' ')}"
    end
  end
end
```
`print_something` method has 19 branches:
- `something` getter called 7 times
- `[]` called on `something` 3 times
- `==` called 2 times
- `puts` called 3 times
- `size` called 3 times
- `join` called 1 time

Could improve code by accessing `@something` directly, or by saving `something` to a local variable (and using a local instead of the getter method)
## Refactoring tips
### Conditions
- Refactor repetitive conditions or complicated conditional expressions
test

