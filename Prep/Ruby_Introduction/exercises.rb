contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}
fields = %i[email address phone]

contact_data.map! { |contact| fields.zip(contact).to_h }
contacts.each_key { |k| contacts[k] = contact_data.shift }
p contacts