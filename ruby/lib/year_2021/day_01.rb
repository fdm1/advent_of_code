# frozen_string_literal: true

module Year2021
  class Day01
    def initialize(input)
      @input = input
    end

    def part1
      res = 0
      input = @input.split("\n")
      input = input.map(&:to_i)
      input.each_with_index do |num, index|
        res += 1 if num > input[index - 1]
      end
      res
    end
  end
end
