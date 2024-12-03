line = ARGF.read.chomp

mults = line.scan(/mul\((\d+),(\d+)\)/).map do |m|
  m[0].to_i * m[1].to_i
end

p mults.sum
