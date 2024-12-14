index = 0
id = 0
files = {}
free_space = []
ARGF.read.chomp.split('').map(&:to_i).each_slice(2) do |file, free|
  files[id] = (index..index + file - 1).to_a
  next if free.nil?

  free_space.concat((index + file..index + file + free - 1).to_a)
  index = index + file + free
  id += 1
end

files.keys.sort.reverse.each do |id|
  max = files[id]
  free_blocks = free_space.slice_when { |i, j| i + 1 != j }

  free_block = free_blocks.find do |block|
    block.size >= max.size && block.max <= max.min
  end

  next if free_block.nil?

  free_block = free_block.take(max.size)

  free_block.each { free_space.delete(_1) }
  free_space.concat(max)

  files[id] = free_block
end

acc = 0
files.each do |id, range|
  range.each do |val|
    acc += (val * id)
  end
end

p acc
