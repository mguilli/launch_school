def staggered_case(str)
  up = true
  str.chars.sum('') do |chr|
    if chr =~ /[a-zA-Z]/
      up ? chr.upcase! : chr.downcase!
      up = !up
    end
    chr
  end
end

p staggered_case('I Love Launch School!') == 'I lOvE lAuNcH sChOoL!'
p staggered_case('ALL CAPS') == 'AlL cApS'
p staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 nUmBeRs'
