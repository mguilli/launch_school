class Transform
  def self.lowercase(word)
    word.downcase
  end

  def initialize(word)
    @word = word
  end  

  def uppercase
    @word.upcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase          # ABC
puts Transform.lowercase('XYZ') # xyz
