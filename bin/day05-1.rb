parts = ARGF.read.split("\n\n").map { _1.split("\n") }

rules = parts[0].map do |rule|
  rule.split('|').map(&:to_i)
end

updates = parts[1].map do |update|
  update.split(',').map(&:to_i)
end

res = updates.map do |update|
  next 0 unless rules.all? do |a, b|
    update.index(a).nil? || update.index(b).nil? || update.index(a) < update.index(b)
  end

  update[(update.size - 1) / 2]
end

p res.sum
