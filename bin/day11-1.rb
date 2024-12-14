initial_stones = ARGF.read.chomp.split.map(&:to_i)

def blink_stone(stone)
  return [1] if stone.zero?

  digits = stone.digits.size
  if digits.even?
    mid = digits / 2
    [stone.to_s[...mid].to_i, stone.to_s[mid..].to_i]
  else
    [stone * 2024]
  end
end

stones = initial_stones
25.times do
  stones = stones.flat_map { blink_stone(_1) }
end

p stones.size
