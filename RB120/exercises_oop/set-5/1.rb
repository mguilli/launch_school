class Banner
  PADDING = 4

  def initialize(message, width=PADDING)
    @message = message.split("\n")
    @message[0] ||= ''
    longest_line = @message.max_by(&:length).size
    @inner_width = [longest_line, width - PADDING].max
  end

  def to_s
    lines = [horizontal_rule, empty_line, *message_line, empty_line, horizontal_rule]
    lines.join("\n")
  end

  private

  def horizontal_rule
    "+-#{'-' * @inner_width}-+"
  end
  
  def empty_line
    "| #{' ' * @inner_width} |"
  end

  def message_line
    @message.map do |line|
      "| #{line.center(@inner_width)} |"
    end
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

banner = Banner.new('')
puts banner
# +--+
# |  |
# |  |
# |  |
# +--+

puts Banner.new("cool\nbeans", 20)
# +------------------+
# |                  |
# |       cool       |
# |      beans       |
# |                  |
# +------------------+
