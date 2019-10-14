require 'pry'
module Walkable
  def walk
    puts "#{self} #{gait} forward"
  end

  def to_s
    name
  end
end

class Person
  attr_reader :name
  include Walkable
  
  def initialize(name)
    @name = name
  end
  
  private
  
  def gait
    "strolls"
  end
end

class Cat
  attr_reader :name
  include Walkable
  
  def initialize(name)
    @name = name
  end
  
  private
  
  def gait
    "saunters"
  end
end

class Cheetah
  attr_reader :name
  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

class Noble
  attr_reader :name, :title
  include Walkable

  def initialize(name, title)
    @name, @title = name, title
  end

  def to_s
    "#{title} #{name}"
  end

  private

  def gait
    'struts'
  end
end

# We need a new class Noble that shows the title and name when walk is called:
byron = Noble.new("Byron", "Lord")
byron.walk
# => "Lord Byron struts forward"

# We must have access to both name and title because they are needed for other purposes that we aren't showing here.
p byron.name
# => "Byron"
p byron.title
# => "Lord"


mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"
