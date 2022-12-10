# frozen_string_literal: true

module Year2022
  class Day10 < AdventOfCode::PuzzleBase
    def initialize(input)
      super(input)
      @cycle = 0
      @signal_strength = 1
      @sprite_chars = ''
      @sprite_positons = []
      @signal_strengths = {}
    end

    def part1
      @input.split("\n").map { |row| process(row) { store_signal_strength } }
      @signal_strengths.values.sum
    end

    def part2
      @input.split("\n").map { |row| process(row, yield_before: true) { process_sprite_char } }
      res = @sprite_chars.chars.each_slice(40).map(&:join).map(&:strip).join("\n").chomp
      # so that the first line is not on the `result:` output line
      "\n#{res}"
    end

    private

    def process(row, yield_before: false)
      yield if yield_before
      @cycle += 1
      yield unless yield_before
      return if row == 'noop'

      to_add = row.split.last
      yield if yield_before
      @cycle += 1
      yield unless yield_before
      @signal_strength += to_add.to_i
    end

    def process_sprite_char
      @sprite_chars += (@signal_strength - (@cycle % 40)).abs <= 1 ? '#' : ' '
    end

    def store_signal_strength
      @signal_strengths[@cycle] = @signal_strength * @cycle if @cycle == 20 || ((@cycle - 20) % 40).zero?
    end
  end
end
