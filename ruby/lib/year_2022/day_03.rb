# frozen_string_literal: true

module Year2022
  class Day03 < PuzzleBase
    CHARS = ('a'..'z').to_a + ('A'..'Z').to_a

    def common_char(row)
      row_chars = row.chars
      midpoint = row_chars.length / 2
      (row_chars[0...midpoint] & row_chars[midpoint..]).first
    end

    def part1
      row_chars = @input.split("\n").map { |row| common_char(row) }
      row_chars.map { |char| CHARS.index(char) + 1 }.sum
    end

    def part2
      rows = @input.split("\n").map(&:chars)
      rows.each_slice(3).collect do |slice|
        common = slice[0] & slice[1] & slice[2]
        CHARS.index(common.first) + 1
      end.sum
    end
  end
end
