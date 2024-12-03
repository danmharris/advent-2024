line = ARGF.read.chomp
enabled = true

mults = line.scan(/(mul\((\d+),(\d+)\)|do\(\)|don't\(\))/).map do |m|
  case m[0]
  when /don/
    enabled = false
    next 0
  when /do/
    enabled = true
    next 0
  end

  if enabled
    m[1].to_i * m[2].to_i
  else
    0
  end
end

p mults.sum
