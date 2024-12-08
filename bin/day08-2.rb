antennas = Hash.new { [] }
data = ARGF.readlines
height = data.size
width = data.first.chomp.size

data.each_with_index do |line, y|
  line.chomp.split('').each_with_index do |val, x|
    next if val == '.'

    antennas[val] = antennas[val].append([x, y])
  end
end

antinodes = []

antennas.each_value do |positions|
  positions.combination(2).each do |pos1, pos2|
    x1, y1 = pos1
    x2, y2 = pos2

    dx = x2 - x1
    dy = y2 - y1

    nx = x1
    ny = y1
    while nx.between?(0, width - 1) && ny.between?(0, height - 1)
      antinodes << [nx, ny]
      nx -= dx
      ny -= dy
    end

    nx = x2
    ny = y2
    while nx.between?(0, width - 1) && ny.between?(0, height - 1)
      antinodes << [nx, ny]
      nx += dx
      ny += dy
    end
  end
end

p antinodes.uniq.count
