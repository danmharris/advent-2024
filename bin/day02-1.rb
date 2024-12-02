def check_report(report)
  pairs = report.zip(report.rotate)
  pairs.pop

  pairs.all? { |a, b| (b - a).between?(1, 3) } ||
    pairs.all? { |a, b| (a - b).between?(1, 3) }
end

reports = ARGF.readlines.map do |line|
  line.split.map(&:to_i)
end

safe = reports.reduce(0) do |acc, report|
  acc + (check_report(report) ? 1 : 0)
end

p safe
