class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

# What will the following code print?
thing = Something.new
puts Something.dupdata  # ByeBye
puts thing.dupdata      # HelloHello
