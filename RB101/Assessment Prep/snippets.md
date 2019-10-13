## Scope

#### Block scope

```ruby
a = nil

loop do 
  a = 3 # a is available withing the block as it is defined in outer scope
  break
end

puts a # => 3
```

```ruby
loop do
  # a is initialized only in the block's local scope, and not available outside the block
  a = 3
  break
end

puts a # Throws NameError: undefined local variable
```

```ruby
# if statements do not create a new block scope. Variables declared in an if/else 
# statement are initialized to nil if assignment does not occur

if false
 b = 42
end
b # => nil
```

#### Variable Shadowing

```ruby
# Ruby will use the inner scope variable, blocking access to the outer scope n variable
n = 4
[1, 2, 3].each do |n|
  puts n # => prints each element of the array
end
puts n # => prints 4
```

#### Method Definitions

```ruby
a = 4

def some_method
	puts a # variable a is initialized outside the method definition, and thus inaccessible
end

some_method # => NameError: undefined local variable 'a'
```

```ruby
a = 4

def some_method(a)
  # Not an instance of variable shadowing, as 'a' from outer scope is not accessible
  puts a
end

some_method(a) # => prints 4
```



## Pointers

```ruby
# Using 'foo' as a default value, points all elements to the same space in memory
a = Array.new(3, 'foo')
p a.map(&:object_id) # => [70102147035480, 70102147035480, 70102147035480]

# mapping 'foo' to each element of an array points all elements to different spaces
a = Array.new(3).map { 'foo' }
p a.map(&:object_id) # => [70102150150080, 70102150150060, 70102150150020]

# Each time 'foo' is referenced, the instance of 'foo' is considered a unique object
3.times { puts 'foo' }
# prints:
# 70102162959060
# 70102162959000
# 70102162958940
```

##### Terminology

`var` references the <> object <>

The object is assigned to the variable `var`

`x` and `y` are aliases for each other, since they reference the same object

`var` was reassigned to the object <>

