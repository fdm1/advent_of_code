# frozen_string_literal: true

module Year2022
  class Day15 < AdventOfCode::PuzzleBase
    def initialize(**args)
      super(**args)
      parse_input
      @part1_yval = @override_args[:yval] || 2_000_000
      @part2_max_val = @override_args[:max_val] || 4_000_000
    end

    def part1
      @min_y = @part1_yval
      @max_y = @part1_yval
      @sensor_distances.each { |sensor, distance| gather_sensor_ranges(sensor, distance) }
      get_empty_positions(@part1_yval).size - sensors_and_beacons_in_y(@part1_yval).size
    end

    def part2
      @min_y = 0
      @max_y = @part2_max_val
      @min_x = 0
      @max_x = @part2_max_val

      @sensor_distances.each { |sensor, distance| gather_sensor_ranges(sensor, distance) }
      test_set = (0..@part2_max_val).to_set
      problem_ranges = @sensor_y_ranges.filter { |_y, ranges| ranges.size > 1 }
      puts "Found #{problem_ranges.size} problem ranges" if @debug
      y_set = problem_ranges.values.first.map(&:to_set).reduce(:+)
      missing = (test_set - y_set)
      if missing.empty?
        puts 'found no hole'
        return
      end
      hole = [missing.first, problem_ranges.keys.first]

      puts "Found #{hole}" if @debug
      tuning_frequency(hole)
    end

    private

    def draw
      special_points = @sensor_positions.to_h { |v| [v, 'S'] }
      special_points.merge!(@beacon_positions.to_h { |v| [v, 'B'] })
      points = @sensor_y_ranges.collect do |y, ranges|
        ranges.map(&:to_a).flatten.collect do |x|
          [x, y]
        end
      end.flatten(1) + special_points.keys
      AdventOfCode::GridDrawer.new(
        points:,
        special_points:,
        no_padding: true,
        reverse_y: false
      ).draw
    end

    def tuning_frequency(point)
      (point[0] * 4_000_000) + point[1]
    end

    def sensors_and_beacons_in_y(y_val)
      @sensor_positions.merge(@beacon_positions).filter { |p| p[1] == y_val }
    end

    def get_empty_positions(y_val)
      return [] if @sensor_y_ranges[y_val].nil?

      puts "Gathering empty positions for y = #{y_val} ... " if @debug
      @sensor_y_ranges[y_val].map(&:to_a).inject(&:|)
    end

    def manhattan_distance(x1, y1, x2, y2)
      (x1 - x2).abs + (y1 - y2).abs
    end

    def gather_sensor_ranges(sensor, distance)
      max_sensor_y = sensor[1] + distance
      min_sensor_y = sensor[1] - distance
      if (@min_y && @min_y > max_sensor_y) || (@max_y && @max_y < min_sensor_y)
        puts "Skipping sensor #{sensor} because it is out of range" if @debug
        return
      end

      min_sensor_y = @min_y if @min_y && @min_y > min_sensor_y
      max_sensor_y = @max_y if @max_y && @max_y < max_sensor_y

      if @debug
        print "Gathering sensor positions for #{sensor} (distance = #{distance}) "
        print "(limiting to #{min_sensor_y} to #{max_sensor_y})... "
      end
      (min_sensor_y..max_sensor_y).each do |y|
        x_dist = distance - (sensor[1] - y).abs

        left = sensor[0] - x_dist
        right = sensor[0] + x_dist
        left = @min_x if @min_x && @min_x > left
        right = @max_x if @max_x && @max_x < right

        @sensor_y_ranges[y] ||= Set.new

        overlapping_ranges = @sensor_y_ranges[y].filter do |r|
          ((r.begin <= left) && r.end >= left - 1) ||
            ((r.end >= right) && r.begin <= right + 1) ||
            (r.begin >= left && r.end <= right)
        end
        overlapping_ranges.each { |r| @sensor_y_ranges[y].delete(r) }

        @sensor_y_ranges[y].add(Range.new(([left] + overlapping_ranges.map(&:begin)).min,
                                          ([right] + overlapping_ranges.map(&:end)).max))
      end
      print 'done' if @debug
      puts if @debug
    end

    def parse_input
      @sensor_y_ranges = {}
      @sensor_distances = {}
      @sensor_positions = Set.new
      @beacon_positions = Set.new
      @input.split("\n").each do |line|
        sensor_str, beacon_str = line.split(':')
        sensor = sensor_str.scan(/(-?\d+)/).flatten.map(&:to_i)
        beacon = beacon_str.scan(/(-?\d+)/).flatten.map(&:to_i)
        @sensor_positions.add(sensor)
        @beacon_positions.add(beacon)
        @sensor_distances[sensor] = manhattan_distance(*sensor, *beacon)
      end
    end

    def prep_sensor_ranges
      @sensor_distances.each { |sensor, distance| gather_sensor_ranges(sensor, distance) }
    end
  end
end
