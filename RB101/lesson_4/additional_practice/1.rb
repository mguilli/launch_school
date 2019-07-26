flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

p flintstones.zip(0...flintstones.size).to_h

i = -1
p flintstones.map { |v| [v, i += 1] }.to_h
p (0...flintstones.size).map { |i| [flintstones[i], i] }.to_h
p (0...flintstones.size).each_with_object({}) { |i, hash| hash[flintstones[i]] = i }
