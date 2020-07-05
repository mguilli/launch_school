class Person
  attr_reader :name

  def name=(name)
    @name = name.capitalize # can use name.capitalize because name shadow variable created from parameter
  end
end

person1 = Person.new
person1.name = 'eLiZaBeTh'
puts person1.name