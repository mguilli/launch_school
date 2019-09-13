# This method causes a stack overflow, as there is no condition to stop recursion
def move(n, from_array, to_array)
  # Added return condition to cease recursion at the appropriate point
  return if n == 0 || from_array.empty?
  to_array << from_array.shift
  move(n - 1, from_array, to_array)
end

# Example

todo = ['study', 'walk the dog', 'coffee with Tom']
done = ['apply sunscreen', 'go to the beach']

move(2, todo, done)

p todo # should be: ['coffee with Tom']
p done # should be: ['apply sunscreen', 'go to the beach', 'study', 'walk the dog']

todo = ['study']
done = ['apply sunscreen', 'go to the beach']

move(2, todo, done)

p todo # should be: ['coffee with Tom']
p done