left, right = ARGF.readlines.map(&:split).transpose

left.map!(&:to_i).sort!
right.map!(&:to_i).sort!

diffs = left.zip(right).map do |pair|
  pair.max - pair.min
end

p diffs.sum
