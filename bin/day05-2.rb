def ordered?(update, rules)
  rules.all? do |a, b|
    update.index(a).nil? || update.index(b).nil? || update.index(a) < update.index(b)
  end
end

parts = ARGF.read.split("\n\n").map { _1.split("\n") }

rules = parts[0].map do |rule|
  rule.split('|').map(&:to_i)
end

updates = parts[1].map do |update|
  update.split(',').map(&:to_i)
end

res = updates.map do |update|
  next 0 if ordered?(update, rules)

  new_update = Array.new(update)

  until ordered?(new_update, rules)
    rules.each do |a, b|
      idx_a = new_update.index(a)
      idx_b = new_update.index(b)
      next unless !idx_a.nil? && !idx_b.nil? && idx_a > idx_b

      tmp = new_update[idx_a]
      new_update[idx_a] = new_update[idx_b]
      new_update[idx_b] = tmp
    end
  end

  new_update[(new_update.size - 1) / 2]
end

p res.sum
