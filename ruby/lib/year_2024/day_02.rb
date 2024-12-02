# frozen_string_literal: true

module Year2024
  class Day02 < AdventOfCode::PuzzleBase
    def part1
      @row_arrays.filter { |r| row_is_safe?(r) }.count
    end

    def part2
      @row_arrays.filter do |r|
        if row_is_safe?(r)
          true
        else
          # brute forcing out of laziness
          r.count.times.collect do |i|
            dup = r.dup
            dup.delete_at(i)
            row_is_safe?(dup)
          end.any?
        end
      end.count
    end

    # setup gets called as part of initialize
    def setup
      @row_arrays = @input.split("\n").map { |r| r.split.map(&:to_i) }
    end

    private

    def row_is_safe?(row_array)
      # handle issues with duplicate values
      return false if row_array.uniq.length != row_array.length

      direction = nil

      row_array.map.with_index do |a, i|
        next if i.zero?

        b = row_array[i - 1]

        if i == 1
          direction = a > b ? 1 : -1
        end

        return false unless correct_direction?(a, b, direction) && safe_distance?(a, b)
      end

      true
    end

    def correct_direction?(a, b, direction)
      return true unless direction

      direction.positive? ? a > b : b > a
    end

    def safe_distance?(x, y)
      return true unless x && y

      distance = (x - y).abs
      distance >= 1 && distance <= 3
    end
  end
end
