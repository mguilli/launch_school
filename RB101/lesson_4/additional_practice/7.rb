statement = "The Flintstones Rock"
statement = statement.tr(' ','')
freq = {}
statement.chars.each { |c| freq[c] = statement.count(c) }
p freq

p statement.chars.each_with_object({}) { |c, arr| arr[c] = statement.count(c) }
