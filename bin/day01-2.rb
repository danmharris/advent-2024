left, right = ARGF.readlines.map(&:split).transpose

left.map!(&:to_i)
right.map!(&:to_i)

score = left.reduce(0) do |s, location|
  s += location * right.count(location)
end

p score
