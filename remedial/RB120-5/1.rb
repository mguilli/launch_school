require 'pry'

class Banner
  PADDING = 1

  def initialize(message, padding=PADDING)
    @message = message.split("\n")
    @message[0] ||= ''
    longest_line = @message.max_by(&:length).size
    @line_width = longest_line + ([PADDING, padding].max * 2)
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+#{'-' * @line_width}+"
  end

  def empty_line
    "|#{' ' * @line_width}|"
  end

  def message_line
    @message.map { |line| "|#{line.center(@line_width)}|"}
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner

banner = Banner.new('')
puts banner

puts Banner.new("cool\nbeans", 20)
