# frozen_string_literal: true

module AdventOfCode
  class GridDrawer
    DEFAULT_PADDING = 4
    def initialize(points:, padding: {}, special_points: {})
      @points = points
      @padding ||= {
        top: padding[:top] || DEFAULT_PADDING,
        bottom: padding[:bottom] || DEFAULT_PADDING,
        left: padding[:left] || DEFAULT_PADDING,
        right: padding[:right] || DEFAULT_PADDING
      }
      @special_points = special_points
    end

    def draw
      puts("\n\n")
      min_x = @points.collect(&:first).min - @padding[:left].to_i
      max_x = @points.collect(&:first).max + @padding[:right].to_i
      min_y = @points.collect(&:last).min - @padding[:top].to_i
      max_y = @points.collect(&:last).max + @padding[:bottom].to_i
      (min_y..max_y).to_a.reverse.each do |y|
        (min_x..max_x).each do |x|
          if @points.include?([x, y])
            print @special_points[[x, y]] || '#'
          else
            print '.'
          end
        end
        puts
      end
    end
  end
end
