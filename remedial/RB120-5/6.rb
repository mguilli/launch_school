class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

# the instance variable @database_handle can be overwritten outside the class.
# Make attr_accessor into a reader, or eliminate altogether
