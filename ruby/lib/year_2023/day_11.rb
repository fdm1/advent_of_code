# frozen_string_literal: true

module Year2023
  class Day11 < AdventOfCode::PuzzleBase
    def part1
      find_total_distance
    end

    def part2
      find_total_distance((@override_args[:size] || 1_000_000) - 1)
    end

    def find_total_distance(expand_size = 1)
      total_distance = 0
      @galaxies.keys.reverse.each do |galaxy|
        other_galaxies = @galaxies.keys.reverse.filter { |k| k < galaxy }
        other_galaxies.each do |other_galaxy|
          total_distance += find_distance(galaxy, other_galaxy, expand_size)
        end
      end
      total_distance
    end

    def find_distance(galaxy, other_galaxy, expand_size = 1)
      g1 = @galaxies[galaxy]
      g2 = @galaxies[other_galaxy]
      x_distance = (g1[0] - g2[0]).abs
      y_distance = (g1[1] - g2[1]).abs

      x_points = [g1[0], g2[0]].sort
      y_points = [g1[1], g2[1]].sort

      @extra_space[:columns].count { |column| column.between?(x_points.first, x_points.last) }.times do
        x_distance += expand_size
      end

      @extra_space[:rows].count { |row| row.between?(y_points.first, y_points.last) }.times do
        y_distance += expand_size
      end

      x_distance + y_distance
    end

    def expand_grid
      empty_columns = @grid.first.length.times.collect { |x| @grid.all? { |row| row[x] == '.' } ? x : nil }.compact
      empty_rows = @grid.each_with_index.collect { |row, y| row.all? { |cell| cell == '.' } ? y : nil }.compact
      @extra_space = { rows: empty_rows, columns: empty_columns }
    end

    def find_galaxies
      @galaxies = {}
      n = 1
      @grid.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          next if cell == '.'

          @galaxies[n] = [x, y]
          n += 1
        end
      end
    end

    # setup gets called as part of initialize
    def setup
      @grid = @input.split("\n").map(&:chars)
      expand_grid
      find_galaxies
    end
  end
end
