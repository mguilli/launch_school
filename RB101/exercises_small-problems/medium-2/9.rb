def bubble_sort!(array)
  n = array.size

  loop do
    last_swap = 0
    i = 1

    while i < n
      if array[i] < array[i-1]
        array[i-1, 2] = array[i-1, 2].reverse
        last_swap = i
      end
      i += 1
    end

    n = last_swap
    break if n <= 1
  end
end

array = [5, 3]
bubble_sort!(array)
p array == [3, 5]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
p array == [1, 2, 4, 6, 7]

array = %w(Sue Pete Alice Tyler Rachel Kim Bonnie)
bubble_sort!(array)
p array == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)