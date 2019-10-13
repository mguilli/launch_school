## Scope

#### Local Variables

- Inner scope can access variables initialized in an outer scope, but not vice versa.
- A variable's scope is defined by where the variable is initialized or created
  - A variable's scope in local context is defined by a block
  - Code delimited by `{}` or `do/end` is a block if it follows a method invocation
    - `if/else`, `case`, `while`, and `for` are control expressions, and do not create a new block scope
    - `loop` is a method

#### Blocks

- A block is actually an argument being passed into a method invocation
- Blocks create a new scope for local variables => an *inner scope*
- Peer blocks cannot access variables initialized in other blocks

#### Variable Shadowing

- Occurs when an inner scope variable shares the same name as an outer scope variable, leading to duplicate variable names

- Ruby will prioritize the most inner scoped variable, blocking access to the outer scope variable

#### Method Definitions

- Method definitions have a self-contained scope
  - Method definition sets the scope for any local variables in terms of parameters
  - If the method is defined to use a block, then the scope of the block can provide additional flexibility in terms of how the method invocation interacts with its surroundings
  - Method invocation uses the scope set my method definition
- Local variables defined outside the method definition are not accessible by the method 
- Local variables must be explicitly passed to the method definition as parameters

#### Constants

- Constants have ***lexical*** scope, and different scoping rules than local variables
- Constants are accessible inside method definitions
-  Constants initialized in an inner scope are accessible to outer scopes

## Pointers

#### Terminology

- An object is a piece of data that has some sort of state (called a value)
- When an object is assigned to a variable, the variable references that object
- Variables store the object id of the object to which they are assigned
  - Variables point to space (address) in memory
- When multiple variables reference the same object, they are aliases for each other
- When a variables value is changed (=), he variable is 'reassigned' to a different object
  - The variable is bound to a different/new object

#### Mutability

- Numbers and booleans are immutable in Ruby
- Assignment is non-mutating (=)
- Indexed assignment is Mutating ( collection[ idx ] = ??? )
- Concatenation is mutating
- `<<` is mutating (concatenation), `+=` is non-mutating (assignment)

#### Pass by Reference Value

- When you pass an object (or expression) as an argument to a method, that object (or expression) is reduced to an object and made available inside the method definition -- this is called *object passing*
- Ruby uses strict evaluation
  - Every expression is evaluated and converted to an object before it is passed along to a method
- When an object is passed as an argument to a method, a reference to the object is bound to the parameter in the method definition. As such, the method parameters are aliases for the method arguments. 
  - Where in other languages variables are objects, in Ruby variables are references to objects
  - Copies of the reference to objects are passed to methods
  - This allows the original object to be mutated if it is mutable, but allows reassignment to disconnect the method parameter from the object references in the method argument



## Collections

#### Actions

- Iteration
  - `each` - Does not consider the return value of the block & returns the original collection
- Transformation
  - `map` - Considers the return value of the block & returns a new collection of the same size
- Selection
  - `select` - Considers the truthiness of the return value of the block & returns a new collection <= original

#### Popular Methods

- `each`
  - Array - maps element value to block variable
  - Hash - maps key & value to a 2-element array. Can use 2 block variables `|k,v|` to access
  - Always returns original collection
- `select` - Enumerable
  - Similar block variables to `each`
  - Returns new collection of same type as original (i.e. Array for array, Hash for hash)
- `map` - Enumerable
  - Similar block variables to `each`
  - Always returns an array
- `any?`/`all?` - Enumerable
  - Returns a boolean based on truthiness of block results
- `each_with_index`- Enumerable
  - Block variables = |object, index|, where object = [key, value] for hash
  - Always returns original collection
- `each_with_object(arg)` - Enumerable
  - Block variables =  |object, arg|, where object = [k, v] for hash
    - arg is the object that will be returned (e.g. '', [], {})
    - arg can be modified inside the block (e.g. arg << 1 to push 1 to an array)
- `first` - Enumerable
  - Returns the first element of an array and first pair of hash ([k, v])
- `include?` - Enumerable
  - Array - returns true if value is in array
  - Hash - returns true if value is a key in the hash
    - Alias for Hash#key? or Hash#has_key?
- `partition` - Enumerable
  - Uses truthiness of block return to divide collection
  - Returns an array of true values and false values => `[[true..], [false..]]`
  - For hashes, with return [k,v] (e.g. [[[k, v], [k, v]], [[k, v]]])
- 