NEXT_LETTERS = {
  'X' => 'M',
  'M' => 'A',
  'A' => 'S',
  'S' => nil
}

def find_letter_indexes(grid, letter)
  indexes = []
  grid.each_with_index do |row, y|
    row.each_with_index do |val, x|
      indexes << [x, y] if val == letter
    end
  end
  indexes
end

def search_direction(grid, pos, dpos, letter)
  next_letter = NEXT_LETTERS[letter]
  return true if next_letter.nil?

  x, y = pos
  dx, dy = dpos
  nx = x + dx
  ny = y + dy

  return false if nx.negative? || ny.negative?
  return false unless grid.dig(ny, nx) == next_letter

  search_direction(grid, [nx, ny], dpos, next_letter)
end

grid = ARGF.readlines.map { _1.chomp.split('') }

directions = [-1, 1].product([-1, 1])

mids = find_letter_indexes(grid, 'M').flat_map do |pos|
  directions.map do |dpos|
    next unless search_direction(grid, pos, dpos, 'M')

    [pos[0] + dpos[0], pos[1] + dpos[1]]
  end.compact
end

res = mids.uniq.count do |pos|
  mids.count(pos) == 2
end

p res
