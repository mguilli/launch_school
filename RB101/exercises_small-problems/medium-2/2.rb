CHARMAP = ('a'..'m').zip('n'..'z').to_h
BLOCKS = CHARMAP.merge(CHARMAP.invert)

def block_word?(str)
  str.downcase!

  used_blocks = []
  str.chars.each do |char|
    return false if used_blocks.include?(char) ||
      used_blocks.include?(BLOCKS[char])

    used_blocks |= [char, BLOCKS[char]]
  end

  true
end

p block_word?('BATCH') == true
p block_word?('BUTCH') == false
p block_word?('jest') == true
p block_word?('abcADE') == false
