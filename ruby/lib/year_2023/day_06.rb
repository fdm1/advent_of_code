# frozen_string_literal: true

module Year2023
  class Day06 < AdventOfCode::PuzzleBase
    def part1
    end

    def part2
    end

    def setup
      times, distances = @input.split("\n").map(&:chomp)
      times = times.split(":").last.split(" ").compact.map(&:to_i)
      distances = distances.split(":").last.split(" ").compact.map(&:to_i)
      @races = times.collect.with_index {|t, i| {time: t, distance: distances[i]}}
    end
  end
end
