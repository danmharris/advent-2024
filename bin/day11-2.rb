stones = ARGF.read.chomp.split.map(&:to_i)

def blink_stone(stone, step, cache)
  return 1 if step == 75
  return cache[[stone, step]] if cache.key?([stone, step])

  digits = stone.digits.size
  next_stones = if stone.zero?
                  [1]
                elsif digits.even?
                  mid = digits / 2
                  [stone.to_s[...mid].to_i, stone.to_s[mid..].to_i]
                else
                  [stone * 2024]
                end

  res = next_stones.flat_map do |st|
    blink_stone(st, step + 1, cache)
  end.sum

  cache[[stone, step]] = res
  res
end

cache = {}

res = stones.map { blink_stone(_1, 0, cache) }

p res.sum
