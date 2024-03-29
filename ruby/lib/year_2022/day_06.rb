# frozen_string_literal: true

module Year2022
  class Day06 < AdventOfCode::PuzzleBase
    def part1
      find_marker(4)
    end

    def part2
      find_marker(14)
    end

    private

    def find_marker(len)
      chars = @input.chomp.chars
      (chars.length - len).times { |i| return i + len if chars[i..i + len - 1].uniq.length == len }
    end
  end
end
