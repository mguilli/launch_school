```ruby
[[1, 2], [3, 4]].map do |arr|
  puts arr.first
  arr.first
end
```

| Line | Action              | Object                               | Side Effect            | Return Value                        | Is Return Value Used?                |
| ---- | ------------------- | ------------------------------------ | ---------------------- | ----------------------------------- | ------------------------------------ |
| 1    | Method call (map)   | Outer array                          | None                   | New array [1, 3]                    | no                                   |
| 1-4  | Block execution     | Each sub-array                       | None                   | Element at index 0 of each subarray | Yes, used by `map` for transormation |
| 2    | method call (first) | Each sub-array                       | None                   | Element at index 0 of sub-array     | Yes, used by `puts`                  |
| 2    | method call (puts)  | Element at index 0 of each sub-array | Prints value to screen | `nil`                               | No                                   |
| 3    | Method call (first) | Each sub-array                       | None                   | Element at index 0 of sub-array     | Yes, as return value of block        |

```ruby
my_arr = [[18, 7], [3, 12]].each do |arr|
  arr.each do |num|
    if num > 5
      puts num
    end
  end
end
```

| Line | Action              | Object                   | Side Effect              | Return value   | Used?                                                  |
| ---- | ------------------- | ------------------------ | ------------------------ | -------------- | ------------------------------------------------------ |
| 1    | variable assignment | n/a                      | None                     | original array | No                                                     |
| 1    | method call (each)  | Outer array              | None                     | Outer array    | yes, assigned to `my_arr`                              |
| 1-7  | block execution     | Each sub-array           | None                     | Each subarray  | No                                                     |
| 2    | Method call (each)  | sub-array                | None                     | Sub-array      | Yes, used to determine return value of block lines 1-7 |
| 2-6  | block execution     | Each integer in subarray | None                     | nil            | No                                                     |
| 3    | if statement        | value of `num`           | None                     | `nil`          | yes, for return value of block lines 2-6               |
| 4    | method call (puts)  | value of integer `num`   | Prints integer to screen | `nil`          | yer, for return value of if statement                  |

```ruby
[[1, 2], [3, 4]].map do |arr|
  arr.map do |num|
    num * 2
  end
end
```

| Line | Action                    | Object                                                       | Side Effect | Return value                                     | Used?                                  |
| ---- | ------------------------- | ------------------------------------------------------------ | ----------- | ------------------------------------------------ | -------------------------------------- |
| 1    | method call (map) - outer | [[1,2], [3, 4]]                                              | none        | [[2,4], [6,8]]                                   | No                                     |
| 1-5  | block execution           | Each sub-array                                               | none        | each sub-array with each element multiplied by 2 | Yes, by outer map for transformation   |
| 2    | method call (map) - inner | Each sub-array                                               | none        | each sub-array with each element multiplied by 2 | Yes, by outer `map` for transformation |
| 2-4  | block execution           | each integer in the sub-array for this iteration of outer `map` | none        | integer doubled                                  | Yes, by inner `map` for transformation |
| 3    | Method call (*)           | each integer in subarray for each iteration of outer map     | none        | integer element doubled                          | Yes, by inner map for transformation   |
