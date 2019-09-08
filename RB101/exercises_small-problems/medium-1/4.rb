# 1000 lights

def initialize_lights(num)
  hash = {}
  1.upto(num) { |key| hash[key] = false }
  hash
end

def flip_switches!(bank, pass, light_count)
  1.upto(light_count) do |switch|
    bank[switch] = !bank[switch] if switch % pass == 0
  end
end

def select_switched_on(lights)
  lights.keys.select { |switch| lights[switch] }
  lights.select { |_, state| state }.keys
end

def toggle_lights(num)
  bank = initialize_lights(num)

  1.upto(num) do |pass_count|
    flip_switches!(bank, pass_count, num)
  end

  select_switched_on(bank)
end

p toggle_lights(5) == [1, 4]
p toggle_lights(10) == [1, 4, 9]
p toggle_lights(10)
