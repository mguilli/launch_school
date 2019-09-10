PUNCT = '({['.chars.zip(')}]'.chars).to_h
LEFT = PUNCT.keys
RIGHT = PUNCT.values

def balanced?(str)
  stack = []
  str.chars.each do |char|
    if char == "\""
      if stack.last == "\""
        return(false) unless stack.pop == char
      else
        stack.push "\""
      end
    else
      stack.push PUNCT[char] if LEFT.include?(char)
      if RIGHT.include?(char)
        removed = stack.pop
        return(false) unless removed == char
      end
    end
  end
  stack.empty?
end

p balanced?('What (is) this?') == true
p balanced?('What is) this?') == false
p balanced?('What (is this?') == false
p balanced?('((What) (is this))?') == true
p balanced?('((What)) (is this))?') == false
p balanced?('Hey!') == true
p balanced?(')Hey!(') == false
p balanced?('What ((is))) up(') == false
p balanced?('Hello "there"') == true
p balanced?('Hell"o') == false  
p balanced?("What 'is' that?") == true
p balanced?("what's that?") == true
p balanced?('([])') == true
p balanced?('(][)') == false
p balanced?('{{{}}}') == true
p balanced?('{{}}}') == false
p balanced?('"({[]})"]') == false
p balanced?('({[)}])') == false
p balanced?('(this "that)"') == false
