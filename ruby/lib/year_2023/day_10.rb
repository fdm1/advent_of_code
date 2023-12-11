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
        grid_char = grid[@y] && grid[@y][@x]
        case grid_char
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

    def part2
      position1 = @positions.first
      binding.pry
      position1.move(@grid)
      while position1.position != @start
        position1.move(@grid)
      end
      @path = position1.visited
    end

    def set_initial_positions
      point_above = [@start[0], @start[1] - 1]
      point_below = [@start[0], @start[1] + 1]
      point_left = [@start[0] - 1, @start[1]]
      point_right = [@start[0] + 1, @start[1]]

      grid_above = @grid[point_above[0]] && @grid[point_above[0]][point_above[1]]
      grid_below = @grid[point_below[0]] && @grid[point_below[0]][point_below[1]]
      grid_left = @grid[point_left[0]] && @grid[point_left[0]][point_left[1]]
      grid_right = @grid[point_right[0]] && @grid[point_right[0]][point_right[1]]

      binding.pry
      @positions = []
      @positions << Position.new(@start[0], @start[1], :up, @grid) if grid_above && ['|', '7', 'F'].include?(grid_above)
      @positions << Position.new(@start[0], @start[1], :down, @grid) if grid_below && ['|', 'J', 'L'].include?(grid_below)
      @positions << Position.new(@start[0], @start[1], :left, @grid) if grid_left && ['-', 'L', 'F'].include?(grid_left)
      @positions << Position.new(@start[0], @start[1], :right, @grid) if grid_right && ['-', '7', 'J'].include?(grid_right)
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
