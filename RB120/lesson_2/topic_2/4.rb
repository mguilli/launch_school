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

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
p bob.name.object_id
p rob.name.object_id
p bob.name == rob.name
