def print_in_box(str)
  width = str.size
  puts "+-#{''.center(width, '-')}-+"
  puts "| #{''.center(width)} |"
  puts "| #{str} |"
  puts "| #{''.center(width)} |"
  puts "+-#{''.center(width, '-')}-+"
end

print_in_box('To boldly go where no one has gone before.')
print_in_box('')

MAX_SIZE = 80

def wrap_box(str)
  width = [MAX_SIZE, str.size].min

  line = "+-#{''.center(width, '-')}-+"
  end_bounds = "| #{''.center(width)} |"

  str = str.chars.each_slice(MAX_SIZE).map(&:join)

  puts line
  puts end_bounds
  str.each { |line| puts "| #{line} |" }
  puts end_bounds
  puts line
end

wrap_box('a' * 80 + 'b' * 80 + 'c' * 80)
