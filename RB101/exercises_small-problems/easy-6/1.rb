DEGREE = "\xC2\xB0"
MINUTES_PER_DEGREE = 60
SECONDS_PER_MINUTE = 60
SECONDS_PER_DEGREE = SECONDS_PER_MINUTE * MINUTES_PER_DEGREE

def dms(angle)
  degree, rem_secs = (angle * SECONDS_PER_DEGREE).divmod(SECONDS_PER_DEGREE)
  minutes, seconds = rem_secs.divmod(SECONDS_PER_MINUTE)
  format(%(#{degree}#{DEGREE}%02d'%02d"), minutes, seconds)

end

p dms(30) == %(30°00'00")
p dms(76.73) == %(76°43'48")
p dms(254.6) == %(254°36'00")
p dms(93.034773) == %(93°02'05")
p dms(0) == %(0°00'00")
p dms(360) == %(360°00'00") || dms(360) == %(0°00'00")
