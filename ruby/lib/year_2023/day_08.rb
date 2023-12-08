# frozen_string_literal: true

module Year2023
  class Day08 < AdventOfCode::PuzzleBase
    def part1
      find_path('AAA', 'ZZZ')
    end

    def part2
      paths = @network.keys.select { |k| k.end_with?('A') }
      distances = paths.to_h { |k| [k, find_path(k, 'Z')] }
      distances.values.reduce(&:lcm)
    end

    def find_path(start, finish)
      steps = 0
      direction_index = 0
      current = start
      seen = []
      until current.end_with?(finish) || seen.include?("#{current}-#{direction_index}")
        steps += 1
        seen << "#{current}-#{direction_index}"
        current = @network[current][@directions[direction_index]]
        direction_index = (direction_index + 1) % @directions.length
      end
      steps
    end

    # setup gets called as part of initialize
    def setup
      directions, network = @input.split("\n\n")
      @directions = directions.chars.map { |c| c == 'L' ? 0 : 1 }
      @network = network.split("\n").to_h do |line|
        point, turns = line.split(' = ')
        left, right = turns.gsub('(', '').gsub(')', '').split(', ')
        [point, [left, right]]
      end
    end
  end
end
