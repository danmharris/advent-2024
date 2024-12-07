lines = ARGF.readlines.map do |line|
  test, nums = line.chomp.split(': ')
  nums = nums.split.map(&:to_i)
  [test.to_i, nums]
end

def evaluate(test, nums, acc)
  return true if acc == test && nums.empty?
  return false if nums.empty? || acc > test

  nums = Array.new(nums)
  val = nums.shift

  evaluate(test, nums, acc * val) ||
    evaluate(test, nums, acc + val) ||
    evaluate(test, nums, "#{acc}#{val}".to_i)
end

res = lines.map do |test, nums|
  start = nums.shift
  evaluate(test, nums, start) ? test : 0
end

p res.sum
