log = [
  {time: 201201, x: 2},
  {time: 201201, y: 7},
  {time: 201201, z: 2},
  {time: 201202, a: 3},
  {time: 201202, b: 4},
  {time: 201202, c: 0}
]

result = [
  {time: 201201, x: 2, y: 7, z: 2},
  {time: 201202, a: 3, b: 4, c: 0},
]

log.inject([]) do |acc, elem|
  time = elem[:time]
  found_by_time = acc.select { |hash| hash.any? {|i| i.include?(time)} }
  found_by_time.empty? ? acc << elem : found_by_time.first.merge!(elem)
  acc
end

# From StackOverflow: http://stackoverflow.com/q/16578023/462015
log.group_by { |e| e[:time] }.map { |_, v| v.reduce(:merge) }
