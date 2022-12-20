# frozen_string_literal: true

module Year2022
  class Day17 < AdventOfCode::PuzzleBase
    SHAPES = %i[horizontal_bar cross elbow vertical_bar cube].freeze
    WIDTH = 7

    def part1
      @max_rocks = rock_limit.positive? ? rock_limit : 2022
      process
    end

    def part2
      @max_rocks = rock_limit.positive? ? rock_limit : 1_000_000_000_000
      process
    end

    private

    def process(timeout = 10)
      env_timeout = ENV.fetch('TIMEOUT', timeout).to_i

      env_timeout = 0 if @debug
      if env_timeout.positive?
        Timeout.timeout(env_timeout) do
          take_step until @rocks_count > @max_rocks
        end
      else
        take_step until @rocks_count > @max_rocks
      end
      @grid_rows.keys.max
    end

    def take_step
      shift_left_or_right
      fall
    end

    def rest_rock
      rock_min = @current_rock.keys.min

      @current_rock.each do |row, cols|
        @grid_rows[row] = if @grid_rows[row].nil?
                            { cols:, shape: @current_shape, count: @rocks_count, rock_min:, height: row }
                          else
                            {
                              cols: cols | @grid_rows[row][:cols],
                              shape: @current_shape,
                              count: @rocks_count,
                              rock_min:,
                              height: row
                            }
                          end
      end
      find_pattern
      fill_in_pattern
      @bottom = @grid_rows.keys.max + 4
      generate_rock
    end

    def find_pattern
      return if @pattern || @rocks_count < @min_pattern_rocks

      reverse_rows = @grid_rows.sort.reverse
      columns = reverse_rows.collect { |_, v| v[:cols] }
      (@jetstream.length...(@grid_rows.size / 2)).each do |p_size|
        shape = reverse_rows[0][1][:shape]
        next unless shape == reverse_rows[p_size][1][:shape]

        column_pattern = columns[0...p_size]
        next unless column_pattern == columns[p_size...(p_size * 2)]

        @pattern = { length: p_size, starting_shape: shape, starting_height: reverse_rows[0][0],
                     rocks: reverse_rows[0][1][:count] - reverse_rows[p_size][1][:count] }
      end
    end

    def fill_in_pattern
      return unless @pattern
      return if @pattern_filled

      multiplier = (@max_rocks - @rocks_count) / @pattern[:rocks]
      @rocks_count += @pattern[:rocks] * multiplier
      @grid_rows.transform_keys! do |v|
        v + (@pattern[:length] * multiplier)
      end
      @pattern_filled = true
    end

    def fall
      new_rock = @current_rock.transform_keys { |k| k - 1 }
      can_fall = new_rock.keys.min.positive? && new_rock.all? do |row_n, row|
        @grid_rows[row_n].nil? || row.all? do |col|
          !@grid_rows[row_n][:cols].include?(col)
        end
      end
      if can_fall
        @current_rock = new_rock
        draw('FALL') if debug
      else
        draw('ABOUT TO REST') if debug
        rest_rock
      end
    end

    def shift_left_or_right
      jetstream_char = @jetstream[@jet_index % @jetstream.length]
      oper = jetstream_char == '<' ? :- : :+
      new_rock = @current_rock.transform_values { |cols| cols.collect { |col| col.send(oper, 1) } }
      cannot_shift = new_rock.any? do |row_n, row|
        will_collide = row.any? { |col| !@grid_rows[row_n].nil? && @grid_rows[row_n][:cols].include?(col) }
        too_far = jetstream_char == '<' ? row.min < 1 : row.max > WIDTH
        will_collide || too_far
      end
      @current_rock = new_rock unless cannot_shift
      draw("SHIFT #{jetstream_char}") if debug
      @jet_index = (@jet_index + 1) % @jetstream.length
    end

    def setup
      @jet_index = 0
      @rocks_count = 0
      @max_height = 0
      @bottom = @max_height + 4
      @current_shape = SHAPES.last
      @grid = Set.new(9.times.collect { |i| [0, i] })
      @jetstream = @input.chomp.chars
      @min_pattern_rocks = @override_args[:min_pattern_rocks] || 50_000
      @grid_rows = {}

      generate_rock
    end

    def generate_rock
      @current_shape = SHAPES[SHAPES.find_index(@current_shape).next % SHAPES.size]

      @current_rock = {
        horizontal_bar: {
          @bottom => [3, 4, 5, 6]
        },
        cross: {
          @bottom + 2 => [4],
          @bottom + 1 => [3, 4, 5],
          @bottom => [4]
        },
        elbow: {
          @bottom + 2 => [5],
          @bottom + 1 => [5],
          @bottom => [3, 4, 5]
        },
        vertical_bar: {
          @bottom + 3 => [3],
          @bottom + 2 => [3],
          @bottom + 1 => [3],
          @bottom => [3]
        },
        cube: {
          @bottom + 1 => [3, 4],
          @bottom => [3, 4]
        }
      }[@current_shape]
      @rocks_count += 1
      draw("GENERATE ROCK #{@current_shape}") if debug
      puts "rocks: #{@rocks_count}" if @debug && (@rocks_count % 1_000).zero?
    end

    def draw(description = '')
      max_height = @current_rock.keys.max + 3
      walls = max_height.times.map { |i| [i, 0] } + max_height.times.map { |i| [i, 8] }
      floor = 9.times.map { |i| [0, i] }
      rock = @current_rock.collect { |row, cols| cols.collect { |col| [row, col] } }.flatten(1)
      grid = @grid_rows.collect { |row, cols| cols[:cols].collect { |col| [row, col] } }.flatten(1)
      points = grid + rock + walls + floor
      points.map! { |p| [p[1], p[0]] }
      special_points = rock.to_h { |p| [p, '@'] }.merge(walls.to_h { |p| [p, '|'] }).merge(floor.to_h do |p|
                                                                                             [p, '=']
                                                                                           end)

      special_points.transform_keys! { |p| [p[1], p[0]] }

      AdventOfCode::GridDrawer.new(points:, special_points:, no_padding: true).draw
      puts description
    end

    def rock_limit
      ENV.fetch('ROCK_LIMIT', 0).to_i
    end

    def debug
      @rocks_count < 20 && @debug
    end
  end
end
