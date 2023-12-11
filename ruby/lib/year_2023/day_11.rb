# frozen_string_literal: true

module Year2023
  class Day11 < AdventOfCode::PuzzleBase
    def part1
      find_total_distance
    end

    def part2; end

    def find_total_distance
      total_distance = 0
      @galaxies.keys.reverse.each do |galaxy|
        other_galaxies = @galaxies.keys.reverse.filter { |k| k < galaxy }
        other_galaxies.each do |other_galaxy|
          total_distance += find_distance(galaxy, other_galaxy)
        end
      end
      total_distance
    end

    def find_distance(galaxy, other_galaxy)
      g1 = @galaxies[galaxy]
      g2 = @galaxies[other_galaxy]
      (g1[0] - g2[0]).abs + (g1[1] - g2[1]).abs
    end

    def expand_grid
      # wide
      empty_columns = []
      @grid.first.each_with_index do |_cell, x|
        empty_columns << x if @grid.all? { |row| row[x] == '.' }
      end
      empty_columns.reverse.each { |x| @grid.each { |row| row.insert(x, '.') } }

      empty_rows = []

      # tall
      @grid.each_with_index do |row, y|
        empty_rows << y if row.all? { |cell| cell == '.' }
      end
      empty_rows.reverse.each { |y| @grid.insert(y, Array.new(@grid.first.length, '.')) }
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
