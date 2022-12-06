# frozen_string_literal: true

module Year2022
  class Day06 < PuzzleBase
    def part1
      find_marker(4)
    end

    def part2
      find_marker(14)
    end

    private

    def find_marker(len)
      chars = @input.chomp.chars
      (chars.length - len).times do |i|
        iter_chars = chars[i..(i + len - 1)]
        return i + len if iter_chars == iter_chars.uniq
      end
    end
  end
end
