data = ARGF.readlines.map(&:chomp)

map = {}
data.each_with_index do |line, y|
  line.split('').each_with_index do |val, x|
    map[[x, y]] = val.to_i
  end
end

starts = map.keys.filter { |pos| map[pos].zero? }

def search(start, map)
  width = map.keys.max_by { |x, _y| x }.first
  height = map.keys.max_by { |_x, y| y }.last
  queue = [start]
  val = 0
  paths = 0

  loop do
    new_queue = []
    until queue.empty?
      x, y = queue.shift

      next unless x.between?(0, width) && y.between?(0, height)
      next unless map[[x, y]] == val

      if val == 9
        paths += 1
        next
      end

      new_queue.push([x, y - 1])
      new_queue.push([x, y + 1])
      new_queue.push([x - 1, y])
      new_queue.push([x + 1, y])
    end

    break if val == 9

    queue = new_queue
    val += 1
  end
  paths
end

scores = starts.map { search(_1, map) }

p scores.sum
