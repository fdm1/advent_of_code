# frozen_string_literal: true

module AdventOfCode
  class Runner
    attr_reader :year, :day, :input_path, :suffix

    def initialize(year:, day:, input_path: nil, suffix: nil, debug: false, override_args: nil) # rubocop:disable Metrics/ParameterLists
      @year = year
      @day = day
      @input_path = input_path
      @suffix = suffix
      @debug = debug
      @override_args = override_args
    end

    def part1
      return unless puzzle_klass

      puts "Running day #{@day} of #{@year} part 1..." unless input_path
      time_run { puzzle_instance.part1 }
    end

    def part2
      return unless puzzle_klass

      puts "Running day #{@day} of #{@year} part 2..." unless input_path
      time_run { puzzle_instance.part2 }
    end

    private

    def time_run
      start = Time.now
      res = yield
      if input_path  # tests
        res
      else
        "Result: #{res}\nRun time: (#{Time.now - start} seconds)"
      end
    end

    def input_data
      @input_data ||= InputLoader.new(year, day, input_path, suffix).input_data
    end

    def puzzle_klass
      @puzzle_klass ||= Object.const_get("Year#{year}::Day#{format('%02d', day)}")
    rescue NameError
      puts "Day #{@day} of #{@year} not implemented"
      nil
    end

    def puzzle_instance
      @puzzle_instance ||= puzzle_klass.new(input: input_data, debug: @debug, override_args: @override_args)
    end
  end
end
