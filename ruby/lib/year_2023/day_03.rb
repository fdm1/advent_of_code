# frozen_string_literal: true

module Year2023
  class Day03 < AdventOfCode::PuzzleBase
    def part1
      parse_input
      @numbers.collect do |row_index, row|
        row.collect do |number_index, number|
          number if symbols_touching_number(row_index, number_index).length.positive?
        end
      end.flatten.compact.map(&:to_i).sum
    end

    def part2
      parse_input
      valid_numbers = @numbers.collect do |row_index, row|
        row.collect do |number_index, number|
          matching_symbols = symbols_touching_number(row_index, number_index, '*')
          if matching_symbols.length.positive?
            [number,
             { number_coords: [row_index, number_index], symbol_coords: matching_symbols }]
          end
        end
      end.flatten(1).compact.to_h
      potential_gears = valid_numbers.values.collect { |n| n[:symbol_coords] }.flatten(1).uniq
      potential_gears.collect do |gear|
        gear_numbers = valid_numbers.select { |_n, d| d[:symbol_coords].include?(gear) }.keys
        next if gear_numbers.length != 2

        gear_numbers.map(&:to_i).inject(:*)
      end.compact.sum
    end

    def symbols_touching_number(row_index, number_index, specific_symbol = nil)
      number_length = @numbers[row_index][number_index].length
      valid_positions = [row_index - 1, row_index + 1].collect do |row|
        Range.new(number_index - 1, number_index + number_length).collect do |column|
          [row, column]
        end
      end.flatten(1)
      valid_positions << [row_index, number_index - 1]
      valid_positions << [row_index, number_index + number_length]
      valid_positions.collect do |row, column|
        next unless @symbols[row]&.keys&.include?(column) && (
          specific_symbol.nil? || (@symbols[row] && @symbols[row][column] == specific_symbol)
        )

        [row, column]
      end.compact
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
            while chars[char_index + 1]&.match?(/[[:digit:]]/)
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
