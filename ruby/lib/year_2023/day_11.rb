# frozen_string_literal: true

module Year2023
  class Day11 < AdventOfCode::PuzzleBase
    def part1
      binding.pry
    end

    def part2
    end

    def expand_grid
    end

    # setup gets called as part of initialize
    def setup
      @grid = @input.split("\n").map(&:chars)
      expand_grid
    end
  end
end
