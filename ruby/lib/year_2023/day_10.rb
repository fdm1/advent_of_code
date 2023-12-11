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
          @x -= 1
        when :down
          @x += 1
        when :left
          @y -= 1
        when :right
          @y += 1
        end
        update_marker(grid)
        update_direction(grid)
      end

      def update_marker(grid)
        @marker = grid[@x][@y]
      end

      def update_direction(_grid)
        case @marker
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
      position1.move(@grid)
      position1.move(@grid) while position1.position != @start
      count_internal_points(position1.visited)
    end

    def set_initial_positions
      point_left = [@start[0], @start[1] - 1]
      point_right = [@start[0], @start[1] + 1]
      point_above = [@start[0] - 1, @start[1]]
      point_below = [@start[0] + 1, @start[1]]

      grid_above = @grid[point_above[0]] && @grid[point_above[0]][point_above[1]]
      grid_right = @grid[point_right[0]] && @grid[point_right[0]][point_right[1]]
      grid_left = @grid[point_left[0]] && @grid[point_left[0]][point_left[1]]
      grid_below = @grid[point_below[0]] && @grid[point_below[0]][point_below[1]]

      @positions = []
      @positions << Position.new(@start[0], @start[1], :up, @grid) if grid_above && ['|', '7', 'F'].include?(grid_above)
      @positions << Position.new(@start[0], @start[1], :down, @grid) if grid_below && ['|', 'J',
                                                                                       'L'].include?(grid_below)
      @positions << Position.new(@start[0], @start[1], :left, @grid) if grid_left && ['-', 'L', 'F'].include?(grid_left)
      @positions << Position.new(@start[0], @start[1], :right, @grid) if grid_right && ['-', '7',
                                                                                        'J'].include?(grid_right)
    end

    def expand_grid
      @grid.each do |row|
        row.unshift('X') && row.push('X')
      end
      @grid.unshift(Array.new(@grid[0].length) { 'X' })
      @grid.push(Array.new(@grid[0].length) { 'X' })
    end

    def next_adjacent_points(point, path)
      res = []
      res << [point[0] - 1, point[1]] if point[0].positive? && @grid[point[0] - 1][point[1]]
      res << [point[0] + 1, point[1]] if @grid[point[0] + 1] && @grid[point[0] + 1][point[1]]
      res << [point[0], point[1] - 1] if point[1].positive? && @grid[point[0]][point[1] - 1]
      res << [point[0], point[1] + 1] if @grid[point[0]][point[1] + 1]
      res.filter { |p| !path.include?(p) }
    end

    def count_internal_points(path)
      open_points = Set.new(@edge_points)
      closed_points = Set.new
      @grid.each_with_index do |row, y| # rubocop:disable Metrics/BlockLength
        row.each_with_index do |_column, x|
          current_point = [y, x]
          next if open_points.include?(current_point)
          next if path.include?(current_point)

          adjacent_points = next_adjacent_points(current_point, path).filter do |p|
            !closed_points.include?(p)
          end + [current_point]
          adjacent_points.map do |_p|
            points_checked = Set.new

            can_get_out = AdventOfCode::Algorithms::BFS.new(
              endpoint: current_point,
              starting_points: open_points
            ).run_search! do |point|
              points_checked << point
              if closed_points.include?(point)
                []
              else
                open_points.include?(point) ? open_points : next_adjacent_points(point, path)
              end
            end
            if can_get_out
              open_points.merge(points_checked)
            else
              closed_points.merge(points_checked)
            end
          end
        end
      end
      closed_points.length
    end

    def setup
      @grid = @input.split("\n").map(&:chars)
      expand_grid # to give exit points for checking for internal or external
      @edge_points = []
      @grid.each_with_index do |row, y|
        start = row.index('S')
        edge = row.index('X')
        @start = [y, start] if start
        @edge_points << [y, edge] if edge
      end
      set_initial_positions
    end
  end
end
