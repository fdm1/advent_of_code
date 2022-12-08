# frozen_string_literal: true

module Year2022
  class Day08 < AdventOfCode::PuzzleBase
    def part1
      res = []
      grid.length.times do |x|
        row_length = grid[x].length
        left = check_row_part1(grid[x])
        right = check_row_part1(grid[x].reverse)

        res << left.each_with_index.collect { |seen, y| "#{x},#{y}" if seen }.compact
        res << right.each_with_index.collect { |seen, y| "#{x},#{row_length - y - 1}" if seen }.compact
      end
      grid[0].length.times do |y|
        col = grid.map { |row| row[y] }
        top = check_row_part1(col)
        bottom = check_row_part1(col.reverse)

        res << top.each_with_index.collect { |seen, x| "#{x},#{y}" if seen }.compact
        res << bottom.each_with_index.collect { |seen, x| "#{col.length - x - 1},#{y}" if seen }.compact
      end
      res = res.flatten.uniq
      res.length
    end

    def part2
      max_score = 0
      grid.length.times do |x|
        grid[x].length.times do |y|
          next if x.zero? || y.zero? || x == grid.length - 1 || y == grid[x].length - 1

          left = check_row_part2(grid[x][0...y].reverse, grid[x][y]).filter { |r| r }.count
          right = check_row_part2(grid[x][(y + 1)...grid[x].length], grid[x][y]).filter { |r| r }.count
          top = check_row_part2(grid.map { |row| row[y] }[0...x].reverse, grid[x][y]).filter { |r| r }.count
          bottom = check_row_part2(grid.map { |row| row[y] }[(x + 1)...grid.length], grid[x][y]).filter { |r| r }.count

          score = left * right * top * bottom
          max_score = score if score > max_score
        end
      end
      max_score
    end

    private

    def grid
      @grid ||= @input.split("\n").map { |line| line.chars.map(&:to_i) }
    end

    def check_row_part2(row, base_height)
      blocked = false
      row.collect do |height|
        next if blocked

        blocked = height >= base_height
        true
      end
    end

    def check_row_part1(row)
      max_height = -1
      row.collect do |height|
        seen = height > max_height
        max_height = height if height > max_height
        seen
      end
    end
  end
end
