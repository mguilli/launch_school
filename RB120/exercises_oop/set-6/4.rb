class Transform
  def self.lowercase(str)
    str.downcase
  end

  def initialize(value)
    @value = value
  end

  def uppercase
    @value.upcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase            # ABC
puts Transform.lowercase('XYZ')   # xyz
