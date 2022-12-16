# frozen_string_literal: true

module Year2022
  class Day10 < AdventOfCode::PuzzleBase
    def initialize(**args)
      super(**args)
      @cycle = 0
      @signal_strength = 1
      @sprite_chars = ''
      @signal_strengths = {}
    end

    def part1
      @input.split("\n").map { |row| process(row) { store_signal_strength } }
      @signal_strengths.values.sum
    end

    def part2
      @input.split("\n").map { |row| process(row) { process_sprite_char } }
      res = @sprite_chars.chars.each_slice(40).map(&:join).map(&:strip).join("\n").chomp
      # so that the first line is not on the `result:` output line
      "\n#{res}"
    end

    private

    def process(row)
      yield
      return if row == 'noop'

      yield
      @signal_strength += row.split.last.to_i
    end

    def process_sprite_char
      @sprite_chars += (@signal_strength - (@cycle % 40)).abs <= 1 ? '#' : ' '
      @cycle += 1
    end

    def store_signal_strength
      @cycle += 1
      @signal_strengths[@cycle] = @signal_strength * @cycle if @cycle == 20 || ((@cycle - 20) % 40).zero?
    end
  end
end
