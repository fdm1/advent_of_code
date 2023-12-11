# frozen_string_literal: true

module Year2023
  class Day11 < AdventOfCode::PuzzleBase
    def part1
      expand_grid
      find_galaxies
      find_total_distance
    end

    def part2
      expand_grid(@override_args[:size] || 1_000_000)

      puts "grid expanded"
      if @override_args[:size] == 10
        puts
        @grid.each { |row| puts row.join }

      end
      puts @extra_space

      find_galaxies
      puts "galaxies found"
      find_total_distance(@override_args[:size] || 1_000_000)
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

      @extra_space[:columns].count { |column| column.between?(g1[0], g2[0]) }.times do
        x_distance += expand_size
      end
      @extra_space[:rows].count { |row| row.between?(g1[1], g2[1]) }.times do
        y_distance += expand_size
      end
      puts "galaxy #{galaxy} to galaxy #{other_galaxy} is #{x_distance} + #{y_distance} = #{x_distance + y_distance}"
      x_distance + y_distance
    end

    def expand_grid(size = 1)
      # wide
      empty_columns = []
      @grid.first.each_with_index do |_cell, x|
        empty_columns << x if @grid.all? { |row| row[x] == '.' }
      end

      # tall
      empty_rows = []
      @grid.each_with_index do |row, y|
        empty_rows << y if row.all? { |cell| cell == '.' }
      end
      # empty_rows.reverse.each { |y| size.times { @grid.insert(y, Array.new(@grid.first.length, '.')) } }
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
    end
  end
end
