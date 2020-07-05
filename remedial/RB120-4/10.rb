class Person
  def name=(name_string)
    @first_name, @last_name = name_string.split
  end

  def name
    [@first_name, @last_name].join(' ')
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name