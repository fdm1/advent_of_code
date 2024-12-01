# frozen_string_literal: true

module Year2023
  class Day01 < AdventOfCode::PuzzleBase
    NUMBERS = {
      'one' => 1,
      'two' => 2,
      'three' => 3,
      'four' => 4,
      'five' => 5,
      'six' => 6,
      'seven' => 7,
      'eight' => 8,
      'nine' => 9
    }.transform_values(&:to_s).freeze

    def part1
      digit_rows = extract_numbers
      digit_rows.collect do |row|
        row.first + row.last
      end.map(&:to_i).sum
    end

    def part2
      converted_rows = @input.split("\n").map { |row| replace_number_strings(row) }
      digit_rows = extract_numbers(converted_rows.join("\n"))
      digit_rows = digit_rows.filter { |row| row.length > 1 }
      digit_rows.collect do |row|
        row.first + row.last
      end.map(&:to_i).sum
    end

    def extract_numbers(input = @input)
      char_rows = input.split("\n").map(&:chars)
      char_rows.map do |row|
        row.filter { |char| char_is_numeric?(char) }.compact
      end
    end

    def char_is_numeric?(char)
      char =~ /[[:digit:]]/
    end

    def get_digit(string_row:, reverse: false)
      pattern = /(#{NUMBERS.keys.map { |k| reverse ? k.reverse : k }.join('|')}|[[:digit:]])/
      string_row = string_row.reverse if reverse
      match = string_row.match(pattern).match(0)
      return match if char_is_numeric?(match)

      NUMBERS[reverse ? match.reverse : match]
    end

    def replace_number_strings(string_row)
      [get_digit(string_row:), get_digit(string_row:, reverse: true)].join
    end
  end
end
