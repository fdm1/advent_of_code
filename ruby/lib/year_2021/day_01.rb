# frozen_string_literal: true

module Year2021
  class Day01
    def part1(input_file)
      res = 0
      input = File.read(input_file).split("\n")
      input = input.map(&:to_i)
      input.each_with_index do |num, index|
        res += 1 if num > input[index - 1]
      end
      res
    end
  end
end
