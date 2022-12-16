# frozen_string_literal: true

module Year2022
  class Day14 < AdventOfCode::PuzzleBase
    def initialize(**args)
      super(**args)
      parse_grid
    end

    def part1
      add_sand until @done
      # draw
      @sand.size
    end

    def part2
      add_floor
      add_sand until @done
      # draw
      @sand.size
    end

    private

    def draw
      min_width =  @sand.collect { |v| v[0] }.min
      max_width =  @sand.collect { |v| v[0] }.max

      @sand = @sand.to_h { |v| [[v[0], 1 - v[1]], 'o'] }
      @grid = @grid.collect { |v| [v[0], 1 - v[1]] }.filter { |v| v[0] >= min_width - 20 && v[0] <= max_width + 20 }
      AdventOfCode::GridDrawer.new(points: @grid, padding: { top: 0, bottom: 0 }, special_points: @sand).draw
    end

    def add_sand
      can_move = true

      grain = [500, 0]
      while can_move == true && !@done
        point_below = @grid.filter { |p| p[0] == grain[0] && p[1] > grain[1] }.min_by { |p| p[1] }

        if point_below.nil?
          @done = true
          return
        end
        grain = [grain[0], point_below[1] - 1]
        left_points_done = false
        left_points = (grain.first - @min_width).times.collect do |i|
          next if left_points_done

          point = [grain.first - i - 1, grain.last + i + 1]
          if @grid.include?(point) || !@grid.include?([point.first, point.last + 1])
            left_points_done = true
            nil
          else
            point
          end
        end.compact
        if left_points.any?
          grain = left_points.last if left_points.any?
        else
          right_points_done = false
          right_points = (@max_width - grain.first).times.collect do |i|
            next if right_points_done

            point = [grain.first + i + 1, grain.last + i + 1]
            if @grid.include?(point) || !@grid.include?([point.first, point.last + 1])
              right_points_done = true
              nil
            else
              point
            end
          end.compact
          grain = right_points.last if right_points.any?
        end

        if !@grid.include?([grain[0] - 1, grain[1] + 1])
          grain = [grain[0] - 1, grain[1] + 1]
        elsif !@grid.include?([grain[0] + 1, grain[1] + 1])
          grain = [grain[0] + 1, grain[1] + 1]
        else
          @grid.add(grain)
          @sand.add(grain)
          @max_width = grain[0] if grain[0] > @max_width
          @min_width = grain[0] if grain[0] < @min_width
          can_move = false
          if grain == [500, 0]
            @done = true
            return
          end
        end
      end
    end

    def parse_input_row(row)
      points = row.split(' -> ').collect { |p| p.split(',').map(&:to_i) }
      @grid.merge(points)
      points.first(points.size - 1).each_with_index.collect do |point, index|
        next_point = points[index + 1]
        current_x, current_y = point
        if point[0] == next_point[0]
          range = point[1] > next_point[1] ? (next_point[1]..point[1]) : (point[1]..next_point[1])
          range.each do |y|
            @grid.add([current_x, y])
          end
        else
          range = point[0] > next_point[0] ? (next_point[0]..point[0]) : (point[0]..next_point[0])
          range.each do |x|
            @grid.add([x, current_y])
          end
        end
      end
    end

    def parse_grid
      @grid = Set.new
      @sand = Set.new
      @input.split("\n").map do |line|
        parse_input_row(line)
      end
      @min_width = @grid.collect { |v| v[0] }.min
      @max_width = @grid.collect { |v| v[0] }.max
      @floor = @grid.collect { |v| v[1] }.max + 2
      @done = false
    end

    # definitely a better way to do this, but :shrug:
    def add_floor
      @floor = @grid.collect { |v| v[1] }.max + 2

      (@min_width - 1000..@max_width + 1000).each do |x|
        @grid.add([x, @floor])
      end
    end
  end
end
