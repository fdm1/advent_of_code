# frozen_string_literal: true

module Year2023
  class Day09 < AdventOfCode::PuzzleBase
    def part1
      @rows.collect { |row| find_next_diff(row) }.sum
    end

    def part2; end

    def find_next_diff(row)
      diffs = (row.length - 1).times.collect { |n| row[n + 1] - row[n] }
      diff = if diffs.uniq.length == 1
               diffs.first
             else
               find_next_diff(diffs)
             end
      row.last + diff
    end

    # setup gets called as part of initialize
    def setup
      @rows = @input.split("\n").map { |row| row.split.map(&:to_i) }
    end
  end
end
