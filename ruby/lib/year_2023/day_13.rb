# frozen_string_literal: true

module Year2023
  class Day13 < AdventOfCode::PuzzleBase
    def part1
      binding.pry
    end

    def part2
    end

    def find_possible_reflections
      @patterns.each do |pattern|
        pattern[:row_matches] = pattern[:rows].collect.with_index {|r, i| r == pattern[:rows][i+1]}
        pattern[:column_matches] = pattern[:columns].collect.with_index {|c, i| c == pattern[:columns][i+1]}
      end
    end

    # setup gets called as part of initialize
    def setup
      @patterns = @input.split("\n\n").collect do |p|
        {
          rows: p.split("\n"),
          columns: p.split("\n").map {|r| r.split("")}.transpose.map {|c| c.join("")},
        }
      end
      find_possible_reflections
    end
  end
end
