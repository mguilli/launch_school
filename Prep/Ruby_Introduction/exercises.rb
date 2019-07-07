contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

contact_data.map { |a| a[0].match(/(.+)@/)[1] }.each_with_index do |m,i|
  key = contacts.find { |k,v| k[/#{m}/i] }.first
  contacts[key][:email] = contact_data[i][0]
  contacts[key][:address] = contact_data[i][1]
  contacts[key][:phone] = contact_data[i][2]
  puts contacts[key]
end