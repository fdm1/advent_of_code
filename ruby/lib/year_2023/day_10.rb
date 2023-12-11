# frozen_string_literal: true

module Year2023
  class Day10 < AdventOfCode::PuzzleBase
    class Position
      attr_reader :x, :y, :direction, :steps, :visited, :marker

      def initialize(x, y, direction, grid)
        @steps = 0
        @x = x
        @y = y
        @direction = direction
        @visited = []
        update_marker(grid)
      end

      def position
        [@x, @y]
      end

      def move(grid)
        @steps += 1
        @visited << position
        case @direction
        when :up
          @y -= 1
        when :down
          @y += 1
        when :left
          @x -= 1
        when :right
          @x += 1
        end
        update_direction(grid)
        update_marker(grid)
      end

      def update_marker(grid)
        @marker = grid[@y][@x]
      end

      def update_direction(grid)
        case grid[@y][@x]
        when '7'
          @direction = @direction == :right ? :down : :left
        when 'J'
          @direction = @direction == :right ? :up : :left
        when 'L'
          @direction = @direction == :left ? :up : :right
        when 'F'
          @direction = @direction == :left ? :down : :right
        end
      end
    end

    def part1
      position1, position2 = @positions

      until position1.visited.include?(position2.position)
        position1.move(@grid)
        position2.move(@grid)
      end

      position1.steps - 1
    end

    def part2; end

    def set_initial_positions
      point_above = [@start[0], @start[1] - 1]
      point_below = [@start[0], @start[1] + 1]
      point_left = [@start[0] - 1, @start[1]]
      point_right = [@start[0] + 1, @start[1]]

      grid_above = @grid[point_above[0]][point_above[1]]
      grid_below = @grid[point_below[0]][point_below[1]]
      grid_left = @grid[point_left[0]][point_left[1]]
      grid_right = @grid[point_right[0]][point_right[1]]

      @positions = []
      @positions << Position.new(@start[0], @start[1], :up, @grid) if grid_above && grid_above != '.'
      @positions << Position.new(@start[0], @start[1], :down, @grid) if grid_below && grid_below != '.'
      @positions << Position.new(@start[0], @start[1], :left, @grid) if grid_left && grid_left != '.'
      return unless grid_right && grid_right != '.'

      @positions << Position.new(@start[0], @start[1], :right, @grid)
    end

    # setup gets called as part of initialize
    def setup
      @grid = @input.split("\n").map(&:chars)
      @grid.each_with_index do |row, y|
        start = row.index('S')
        @start = [start, y] if start
      end
      set_initial_positions
    end
  end
end
