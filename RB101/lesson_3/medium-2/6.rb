def color_valid(color)
  if color == "blue" || color == "green"
    true
  else
    false
  end
  # more terse
  %w[blue gree].include? color
end