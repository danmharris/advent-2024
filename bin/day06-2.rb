require 'set'

data = ARGF.readlines
height = data.size
width = data.first.chomp.size
obstructions = []
start = nil

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

def check_loop(start, obstructions, width, height)
  visited = Hash.new { Set.new }
  direction = 0
  current = start

  while current[0].between?(0, width - 1) && current[1].between?(0, height - 1)
    return true if visited[current].include?(direction)

    visited[current] = visited[current].add(direction)

    adj = move(current, direction)
    if obstructions.include?(adj)
      direction = (direction + 1) % 4
      next
    end

    current = move(current, direction)
  end
  false
end

def travel(start, obstructions, width, height)
  current = start
  direction = 0
  visited = {}

  while current[0].between?(0, width - 1) && current[1].between?(0, height - 1)
    visited[current] = direction

    adj = move(current, direction)
    if obstructions.include?(adj)
      direction = (direction + 1) % 4
      next
    end

    current = move(current, direction)
  end
  visited
end

visited = travel(start, obstructions, width, height)
stucks = {}

visited.each_key do |v|
  new_obstructions = Array.new(obstructions).append(v)
  stucks[v] = true if check_loop(start, new_obstructions, width, height)
end

p stucks.count
