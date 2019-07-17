**Question 1**
The code will print:
```
1
2
2
3
```
Array#uniq returns a new array with duplicate items removed. However, when invoked in this case, the new array was not assigned to the variable `numbers`, so `numbers` remained unchanged.

**Question 2**
`!` and `?` have a multitude of uses in Ruby. 

`!` negates the boolean value of an object when preprended to a variable name. `!false == true` and `![1,2,3] == false`. Prepending `!` to = serves as a 'not equal to' conditional operator. By convention, destructive methods are often appended with a `!`, such as Array#map! -- which changes that array on which it is invoked.

Prepending `?` before a single character converts that character into a single character string: `?w == 'w'`. `? :`  is the ternary if/else operator. It is best practice to append `?` to a the method name to indicate that the method returns a boolean value.

**Question 4**
Array#delete(obj) deletes all instances of an object from an array and returns the last item deleted (or nil if no object found)

Array#delete_at takes an index as an argument, deletes the object located at that index and returns the deleted object (or nil if the index is out of range)
