# frozen_string_literal: true

module Year2023
  class Day04 < AdventOfCode::PuzzleBase
    def part1
      parse_input
      counts = @cards.collect do |numbers|
        (numbers[:actual] & numbers[:answers]).count
      end.reject(&:zero?)
      counts.collect do |n|
        res = 1
        (n - 1).times { res *= 2 }
        res
      end.sum
    end

    def part2
      parse_input
      @cards.each_with_index do |current_card, current_index|
        matches = (current_card[:actual] & current_card[:answers]).count
        @cards[current_index + 1..current_index + matches].each do |card|
          card[:copies] += current_card[:copies]
        end
      end
      @cards.collect { |c| c[:copies] }.sum
    end

    def parse_input
      @cards = []
      rows = @input.split("\n")
      cards = rows.map { |r| r.split(': ') }
      cards.each do |card_and_number|
        numbers = card_and_number[1].strip
        actual = numbers.split(' | ')[0].split.map(&:to_i)
        answers = numbers.split(' | ')[1].split.map(&:to_i)
        @cards << { actual:, answers:, copies: 1 }
      end
    end
  end
end
