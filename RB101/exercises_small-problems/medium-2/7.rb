def friday_13th(year)
  day = 13
  dates = (1..12).map { |month| Time.new(year, month, day) }
  dates.count { |date| date.wday == 5 }
end

p friday_13th(2015) == 3
p friday_13th(1986) == 1
p friday_13th(2019) == 2
