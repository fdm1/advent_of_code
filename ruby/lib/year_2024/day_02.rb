# frozen_string_literal: true

module Year2024
  class Day02 < AdventOfCode::PuzzleBase
    def part1
      @row_arrays.filter { |r| row_is_safe?(r, false) }.count
    end

    def part2
      @row_arrays.filter { |r| row_is_safe?(r, true) }.count
    end

    # setup gets called as part of initialize
    def setup
      @row_arrays = @input.split("\n").map { |r| r.split.map(&:to_i) }
    end

    private

    def row_is_safe?(row_array, allow_bad_level)
      direction = nil

      # handle issues with duplicate values
      uniq_row = row_array.uniq
      if uniq_row.length != row_array.length && !allow_bad_level
        return false
      elsif uniq_row.length == row_array.length - 1 && allow_bad_level
        return row_is_safe?(uniq_row, false)
      end

      row_array.collect.with_index do |a, i|
        b = row_array[i - 1]

        next if i.zero? # can't do anything based on first number alone

        if i == 1
          direction = a > b ? 1 : -1
        end

        unless correct_direction?(a, b, direction) && safe_distance?(a, b)
          return false unless allow_bad_level

          dup1 = row_array.dup
          dup1.delete_at(i)
          return true if row_is_safe?(dup1, false)

          dup2 = row_array.dup
          dup2.delete_at(i - 1)
          return row_is_safe?(dup2, false)
        end
      end

      true
    end

    def correct_direction?(a, b, direction)
      return true unless direction

      direction.positive? ? a > b : b > a
    end

    def safe_distance?(x, y)
      distance = (x - y).abs
      distance >= 1 && distance <= 3
    end
  end
end
