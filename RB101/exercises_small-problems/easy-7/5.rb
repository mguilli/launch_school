def staggered_case(str)
  str.chars.map.with_index { |chr, i| i.even? ? chr.upcase : chr.downcase }.join

  # Alternatively
  result = str.chars.each_slice(2).flat_map do |pair|
    pair[-1].downcase!
    pair[0].upcase!
    pair
  end
  result.join
end

p staggered_case('I Love Launch School!') == 'I LoVe lAuNcH ScHoOl!'
p staggered_case('ALL_CAPS') == 'AlL_CaPs'
p staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 NuMbErS'
