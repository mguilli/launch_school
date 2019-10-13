Given:

```ruby
var1 = 8
var2 = var 1
var1 = 2
```

What is the value of var2, and why?

Answer:

The value of `var2` is 8.

After line 2 of the code, both variables point to the same space in memory containing the value 8. On line 3 `var1` is reassigned a reference pointing to a new space in memory containing the value 2.  The original value of 8 is not changed to 2 in place, but instead `var1` is pointed to a new space in memory, leaving `var2` still pointing to the space in memory that contained the value 8.

---

Given the code:

```ruby
arr1 = [1,2,3]
arr2 = arr1.dup
arr2.map! {|x| x*2 }
```

What will be the value of arr1 and arr2, and why?

Answer:

`arr1` will remain unchanged, while `arr2` will contain elements whose values are twice that in `arr1`. This is because `arr2` is a shallow copy, whose elements are integers. Integers are immutable, so methods called on elements of `arr2` will not affect the values of the elements in `arr1`.

---

What is the value returned from the following code?

```ruby
if false
 b = 42
end
b
```

Answer:

`nil` will be returned. Although line 2 of the code is never executed, variables declared in an if/else statement are initialized to a value of `nil`, even if no assignment occurs.

----

For the following code:

```ruby
arr1 = ['a', 'b', 'c']
arr2 = arr1.dup
arr2.map(&:upcase!)
```

What will be the values of arr1 & arr2, and why?

Answer:

Both `arr1` and `arr2` will contain uppercase letters. While `arr2` is a copy of `arr1`, it is a shallow copy. Meaning, that while the two arrays refer to different spaces in memory, their elements are identical references to the same blocks in memory. Mutating one of the strings in `arr2` changes the value of the string that the corresponding element in `arr1` also points to. If one were to inspect the `object_id` of each string element in `arr1`, they would be identical to the string elements of `arr2`

---

What does the following code return?

```ruby
hash = Hash.new(20)
hash[4] += 10
hash
```

Answer:

The final value of `hash` is `{4 => 30}`. On line 2 the default value of the hash element (20) is added to 10 and assigned to the value of the key 4 in the hash. 

---

What is the result of the following?

```ruby
false == nil 
```

Answer: `false` will be returned. While `nil` is a falsey value, it is not equivalent to `false`.

---

What does the following code return?

```ruby
hash = Hash.new(20)
puts hash[3]
hash
```

Answer: 

`20` will be printed to the terminal screen, and an empty hash will be returned. While `hash[3]` returns the default value of `20` as a result of evaluation, no value is assigned to the key `3` in the hash. Default hash values are not stored automatically when invoked.

---

Is Ruby pass by reference or pass by value?

Answer: 

Neither. In ruby, objects are shared to methods. Reassignment of a value to a variable in a method does not affect the object outside of the method's scope. However, mutating the object inside a method does affect the original object.

---

What will the following code output?

```ruby
a = 4
b = 2

2.times do |a|
  a = 5
  puts a
end

puts a
puts b
```

Answer:

It will print

> 5
>
> 5
>
> 4
>
> 2

On line 4 `a` is declared