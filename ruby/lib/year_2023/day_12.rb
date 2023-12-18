# frozen_string_literal: true

module Year2023
  class Day12 < AdventOfCode::PuzzleBase
    def part1
    end

    def part2
    end

    # setup gets called as part of initialize
    def setup
      @springs = @input.split("\n").map do |r|
        springs, counts = r.split(" ")
        { springs: springs, counts: counts.split(",").map(&:to_i)}
      end
    end
  end
end
