# frozen_string_literal: true

module Year2023
  class Day03 < AdventOfCode::PuzzleBase
    def part1
      parse_input
      @numbers.collect do |row_index, row|
        row.collect do |number_index, number|
          number if number_touching_symbol?(row_index, number_index)
        end
      end.flatten.compact.map(&:to_i).sum
    end

    def part2
    end

    def number_touching_symbol?(row_index, number_index)
      number_length = @numbers[row_index][number_index].length
      valid_positions = [row_index - 1, row_index + 1].collect do |row|
        Range.new(number_index - 1, number_index + number_length).collect do |column|
          [row, column]
        end
      end.flatten(1)
      valid_positions << [row_index, number_index - 1]
      valid_positions << [row_index, number_index + number_length]
      valid_positions.any? do |row, column|
        @symbols[row] && @symbols[row].keys.include?(column)
      end
    end


    def parse_input
      rows = @input.split("\n")
      @symbols = {}
      @numbers = {}
      rows.each_with_index do |row, row_index|
        chars = row.chars
        char_index = 0
        @symbols[row_index] = {}
        @numbers[row_index] = {}
        while char_index < chars.length
          char = chars[char_index]
          if char.match?(/[[:digit:]]/)
            number = char
            number_index = char_index
            while chars[char_index + 1] && chars[char_index + 1].match?(/[[:digit:]]/)
              number += chars[char_index + 1]
              char_index += 1
            end
            @numbers[row_index][number_index] = number
          elsif char != '.'
            @symbols[row_index][char_index] = char
          end
          char_index += 1
        end
      end
    end
  end
end
