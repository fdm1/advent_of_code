# frozen_string_literal: true

module Year2024
  class Day01 < AdventOfCode::PuzzleBase
    def part1
      @left.collect.with_index do |l, i|
        (@right[i] - l).abs
      end.sum
    end

    def part2
      @left.collect do |i|
        @right.filter {|r| r == i}.length * i
      end.sum
    end

    # setup gets called as part of initialize
    def setup
      input_arrays
    end

    def input_arrays
      str_num_arrays = @input.split("\n").map(&:split)
      @left = str_num_arrays.map(&:first).map(&:to_i).sort
      @right = str_num_arrays.map(&:last).map(&:to_i).sort
    end
  end
end
