# frozen_string_literal: true

module Year2024
  class Day04 < AdventOfCode::PuzzleBase
    def part1
      input_match_count
    end

    def part2
      res = 0
      @forward.each_with_index do |row, row_index|
        row.chars.each_with_index do |_, col_index|
          res += 1 if is_xmas?(row_index, col_index)
        end
      end
      res
    end

    # setup gets called as part of initialize
    # input is available as the raw input string
    def setup
      @forward = @input.split("\n")
      @down = @input.split("\n").map(&:chars).transpose.map(&:join)
      @down_right_diagonals = collect_diagonals(@forward)
      @down_left_diagonals = collect_diagonals(@forward.map(&:reverse))
    end

    def collect_diagonals(arr)
      res = []
      # go from bottom to top of first column
      arr.count.times do |row|
        current = []
        cursor = [arr.count - row - 1, 0]
        while cursor[0] < arr.length && cursor[1] < arr.first.length
          current << arr[cursor[0]][cursor[1]]
          cursor = [cursor[0] + 1, cursor[1] + 1]
        end
        res << current.join
      end

      # go across the top row. -1 is to not double count top left corner to bottom right corner
      (arr.first.length - 1).times do |col|
        current = []
        cursor = [0, arr.first.length - col - 1]
        while cursor[0] < arr.first.length && cursor[1] < arr.length
          current << arr[cursor[0]][cursor[1]]
          cursor = [cursor[0] + 1, cursor[1] + 1]
        end
        res << current.join
      end

      res.filter { |str| str.length >= 4 }
    end

    def input_match_count(match = 'XMAS')
      array_match_count(@forward, match) +
        array_match_count(@down, match) +
        array_match_count(@down_right_diagonals, match) +
        array_match_count(@down_left_diagonals, match)
    end

    def is_xmas?(row, col)
      # only check A's, and can't be on the edge
      return false unless @forward[row][col] == 'A'
      return false unless row < @forward.length - 1 && row.positive?
      return false unless col < @forward.first.length - 1 && col.positive?

      top_left = @forward[row - 1][col - 1]
      top_right = @forward[row - 1][col + 1]
      bottom_left = @forward[row + 1][col - 1]
      bottom_right = @forward[row + 1][col + 1]

      diag1 = [top_left, bottom_right].sort
      diag2 = [top_right, bottom_left].sort

      diag1 == %w[M S] && diag2 == %w[M S]
    end

    def array_match_count(arr, match)
      forward_sum = arr.collect { |str| string_match_count(str, match) }.sum
      rev_sum = arr.map(&:reverse).collect { |str| string_match_count(str, match) }.sum
      forward_sum + rev_sum
    end

    def string_match_count(str, match)
      str.scan(match).count
    end
  end
end
