class Person
  attr_accessor :first_name, :last_name

  def initialize(n)
    parse_name(n)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(n)
    parse_name(n)
  end

  private

  def parse_name(n)
    self.first_name, self.last_name = n.split
    self.last_name ||= ''
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'
