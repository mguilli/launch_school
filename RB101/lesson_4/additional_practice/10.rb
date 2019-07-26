munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
groups = {'kid' => 0..17, 'adult' => 18..64, 'senior' => 65..}
munsters.each_value do |stats|
  stats["age_group"] =
    case stats['age']
    when 0..17 then 'kid'
    when 18..64 then 'adult'
    else 'senior'
    end
end

p munsters
