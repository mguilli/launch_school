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

matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

new_matrix = transpose(matrix)

p new_matrix == [[1, 4, 3], [5, 7, 9], [8, 2, 6]]
p matrix == [[1, 5, 8], [4, 7, 2], [3, 9, 6]]

p transpose([[1, 2], [3, 4], [5, 6]]) == [[1, 3, 5], [2, 4, 6]]
