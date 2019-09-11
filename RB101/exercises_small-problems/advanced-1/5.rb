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

def rotate90(matrix)
  transpose(matrix).map(&:reverse)
end

def rotate_matrix(matrix, angle)
  rotations = angle / 90
  new_matrix = matrix
  rotations.times { new_matrix = rotate90(new_matrix) }
  new_matrix
end

matrix1 = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

matrix2 = [
  [3, 7, 4, 2],
  [5, 1, 0, 8]
]

new_matrix1 = rotate90(matrix1)
new_matrix2 = rotate90(matrix2)
new_matrix3 = rotate90(rotate90(rotate90(rotate90(matrix2))))

p new_matrix1 == [[3, 4, 1], [9, 7, 5], [6, 2, 8]]
p new_matrix2 == [[5, 3], [1, 7], [0, 4], [8, 2]]
p new_matrix3 == matrix2

matrix = [[1, 2], [3, 4]]
p rotate_matrix(matrix, 180) == [[4, 3], [2, 1]]
p matrix == [[1, 2], [3, 4]]
