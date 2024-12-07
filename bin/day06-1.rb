data = ARGF.readlines
height = data.size
width = data.first.chomp.size
obstructions = []
start = nil
direction = 0
visited = {}

data.each_with_index do |line, y|
  line.chomp.split('').each_with_index do |val, x|
    case val
    when '.'
      next
    when '#'
      obstructions << [x, y]
    when '^'
      start = [x, y]
    end
  end
end

current = start

def move(current, direction)
  case direction
  when 0
    [current[0], current[1] - 1]
  when 1
    [current[0] + 1, current[1]]
  when 2
    [current[0], current[1] + 1]
  when 3
    [current[0] - 1, current[1]]
  end
end

while current[0].between?(0, width - 1) && current[1].between?(0, height - 1)
  visited[current] = true

  adj = move(current, direction)
  direction = (direction + 1) % 4 if obstructions.include?(adj)

  current = move(current, direction)
end

p visited.count
