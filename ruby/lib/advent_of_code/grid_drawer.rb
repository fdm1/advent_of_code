# frozen_string_literal: true

module AdventOfCode
  class GridDrawer
    DEFAULT_PADDING = 4
    def initialize(points:, padding: {}, special_points: {}, no_padding: false, reverse_y: true)
      @points = points
      @padding ||= {
        top: padding[:top] || (no_padding ? 0 : DEFAULT_PADDING),
        bottom: padding[:bottom] || (no_padding ? 0 : DEFAULT_PADDING),
        left: padding[:left] || (no_padding ? 0 : DEFAULT_PADDING),
        right: padding[:right] || (no_padding ? 0 : DEFAULT_PADDING)
      }
      @special_points = special_points
      @reverse_y = reverse_y
    end

    def draw
      puts("\n\n")
      min_x = @points.collect(&:first).min - @padding[:left].to_i
      max_x = @points.collect(&:first).max + @padding[:right].to_i
      min_y = @points.collect(&:last).min - @padding[:top].to_i
      max_y = @points.collect(&:last).max + @padding[:bottom].to_i
      y_range = @reverse_y ? (min_y..max_y).to_a.reverse : (min_y..max_y).to_a
      y_range.each do |y|
        (min_x..max_x).each do |x|
          if @points.include?([x, y])
            print @special_points[[x, y]] || '#'
          else
            print '.'
          end
        end
        puts
      end
      nil
    end
  end
end
