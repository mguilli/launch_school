def transpose(matrix)
  rows, columns = matrix.size, matrix[0].size
  new_matrix = Array.new(columns) { Array.new(rows) }

  rows.times do |row|
    columns.times do |col|
      new_matrix[col][row] = matrix[row][col]
    end
  end

  new_matrix
end

p transpose([[1, 2, 3, 4]]) == [[1], [2], [3], [4]]
p transpose([[1], [2], [3], [4]]) == [[1, 2, 3, 4]]
p transpose([[1, 2, 3, 4, 5], [4, 3, 2, 1, 0], [3, 7, 8, 6, 2]]) ==
  [[1, 4, 3], [2, 3, 7], [3, 2, 8], [4, 1, 6], [5, 0, 2]]
p transpose([[1]]) == [[1]]
