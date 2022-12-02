# frozen_string_literal: true

module AdventOfCode
  class Runner
    attr_reader :year, :day, :input_path

    def initialize(year, day, input_path = nil)
      @year = year
      @day = day
      @input_path = input_path
    end

    def part1
      return unless puzzle_klass

      puts "Running day #{@day} of #{@year} part 1..." unless input_path
      puzzle_instance.part1
    end

    def part2
      return unless puzzle_klass

      puts "Running day #{@day} of #{@year} part 2..." unless input_path
      puzzle_instance.part2
    end

    private

    def input_data
      @input_data ||= InputLoader.new(year, day, input_path).input_data
    end

    def puzzle_klass
      @puzzle_klass ||= Object.const_get("Year#{year}::Day#{format('%02d', day)}")
    rescue NameError
      puts "Day #{@day} of #{@year} not implemented"
      nil
    end

    def puzzle_instance
      @puzzle_instance ||= puzzle_klass.new(input_data)
    end
  end
end
