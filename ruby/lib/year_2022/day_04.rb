# frozen_string_literal: true

module Year2022
  class Day04 < PuzzleBase
    def parse_ranges(row)
      range1, range2 = row.split(',')
      range1_parts = range1.split('-').map(&:to_i)
      range2_parts = range2.split('-').map(&:to_i)
      [
        (range1_parts[0]..range1_parts[1]),
        (range2_parts[0]..range2_parts[1])
      ]
    end

    def part1
      @input.split("\n").count do |row|
        range1, range2 = parse_ranges(row)
        range1.cover?(range2) || range2.cover?(range1)
      end
    end

    def part2
      @input.split("\n").count do |row|
        range1, range2 = parse_ranges(row)
        !(range1.to_a & range2.to_a).empty?
      end
    end
  end
end
