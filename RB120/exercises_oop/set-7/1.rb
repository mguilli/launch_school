class Machine
  def start
    flip_switch(:on)
  end
  
  def stop
    flip_switch(:off)
  end

  def display_switch_state
    switch
  end

  private

  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

machine = Machine.new
machine.start
puts machine.display_switch_state
