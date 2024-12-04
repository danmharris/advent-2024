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

def search_direction(letters, pos, dpos, letter)
  return true if NEXT_LETTERS[letter].nil?

  next_letter = NEXT_LETTERS[letter]
  positions = letters[next_letter]

  x, y = pos
  dx, dy = dpos
  new_pos = [x + dx, y + dy]

  return false unless positions.include?(new_pos)

  search_direction(letters, new_pos, dpos, next_letter)
end

grid = ARGF.readlines.map { _1.chomp.split('') }

letters = {
  'X' => find_letter_indexes(grid, 'X'),
  'M' => find_letter_indexes(grid, 'M'),
  'A' => find_letter_indexes(grid, 'A'),
  'S' => find_letter_indexes(grid, 'S')
}

directions = (-1..1).to_a.product((-1..1).to_a)
directions.delete([0, 0])

res = letters['X'].map do |pos|
  directions.count do |dpos|
    search_direction(letters, pos, dpos, 'X')
  end
end

p res.sum
