# frozen_string_literal: true

module Year2023
  class Day08 < AdventOfCode::PuzzleBase
    def part1
      steps = 0
      direction_index = 0
      current = 'AAA'
      while current != 'ZZZ'
        steps += 1
        current = @network[current][@directions[direction_index]]
        direction_index = (direction_index + 1) % @directions.length
      end
      steps
    end

    def part2
      steps = 0
      direction_index = 0
      paths = @network.keys.select { |k| k.end_with?('A') }

      # improvement idea: collect length to Z, and once we have that, do some math to find the shortest path?
      until paths.all? { |p| p.end_with?('Z') }
        steps += 1
        paths = paths.collect { |path| @network[path][@directions[direction_index]] }
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
