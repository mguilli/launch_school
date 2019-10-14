class Book
  attr_accessor :title, :author

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)
# Expected output:

# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

# Further Exploration
# What do you think of this way of creating and initializing Book objects? (The two steps are separate.) Would it be better to create and initialize at the same time like in the previous exercise? What potential problems, if any, are introduced by separating the steps?

# In cases where the state of an object is subject to change, then separating creation
# and initialiation makes sense, as you would need a way in which to alter the object's state.
# However, in this instance, the book is unlikely to have a change in author or title, 
# thus providing setter methods for those instance variables could lead to unintended mutation 
# elsewhere in the code.
