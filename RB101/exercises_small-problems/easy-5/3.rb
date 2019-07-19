MINUTES_IN_HOUR = 60
HOURS_IN_DAY = 24
MINUTES_IN_DAY = MINUTES_IN_HOUR * HOURS_IN_DAY

def after_midnight(str)
  hours, minutes = str.split(':').map(&:to_i)
  hours %= HOURS_IN_DAY

  hours * MINUTES_IN_HOUR + minutes
end

def before_midnight(str)
  (MINUTES_IN_DAY - after_midnight(str)) % MINUTES_IN_DAY
end

p after_midnight('00:00') == 0
p before_midnight('00:00') == 0
p after_midnight('12:34') == 754
p before_midnight('12:34') == 686
p after_midnight('24:00') == 0
p before_midnight('24:00') == 0
