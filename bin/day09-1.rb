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

loop do
  id, max = files.max_by { _2.min }
  free_blocks = free_space.take(max.size).filter { _1 < max.min }

  break if free_blocks.empty?

  free_blocks.each { free_space.delete(_1) }

  files[id] = free_blocks.concat(files[id][...-free_blocks.size])
end

acc = 0
files.each do |id, range|
  range.each do |val|
    acc += (val * id)
  end
end

p acc
