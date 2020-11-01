class Machine
  def start
    self.flip_switch(:on)
  end
  
  def stop
    self.flip_switch(:off)
  end

  private

  attr_writer :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

machine = Machine.new
p machine.instance_variable_get(:@switch)
machine.start
p machine.instance_variable_get(:@switch)
machine.stop
p machine.instance_variable_get(:@switch)

begin
  p machine.switch
rescue NoMethodError
  p 'Cannot access Machine::switch!'
end
