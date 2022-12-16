# frozen_string_literal: true

module AdventOfCode
  class PuzzleBase
    def initialize(input:, debug: false, override_args: nil)
      @input = input
      @debug = debug || ENV.fetch('DEBUG', nil)
      @override_args = override_args || {}
    end

    def part1
      'Part 1 not implemented yet'
    end

    def part2
      'Part 2 not implemented yet'
    end
  end
end
