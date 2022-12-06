# frozen_string_literal: true

module Year2022
  class Day02 < AdventOfCode::PuzzleBase
    GUIDE = {
      rock: %w[A X],
      paper: %w[B Y],
      scissors: %w[C Z]
    }.freeze

    SHAPE_POINTS = {
      rock: 1,
      paper: 2,
      scissors: 3
    }.freeze

    STRATEGY_GUID = {
      lose: 'X',
      draw: 'Y',
      win: 'Z'
    }.freeze

    def get_shape(char)
      GUIDE.keys.find { |key| GUIDE[key].include?(char) }
    end

    def score_game(other, you)
      return 3 if you == other

      if (you == :rock && other == :paper) ||
         (you == :paper && other == :scissors) ||
         (you == :scissors && other == :rock)
        return 0
      end

      6
    end

    def pick_shape_on_strategy(strategy, other_shape)
      if strategy == 'X'
        return :scissors if other_shape == :rock
        return :rock if other_shape == :paper
        return :paper if other_shape == :scissors
      end
      return other_shape if strategy == 'Y'

      return :paper if other_shape == :rock
      return :scissors if other_shape == :paper
      return :rock if other_shape == :scissors
    end

    def part1
      res = 0
      @input.split("\n").map do |line|
        other, you = line.split.map { |char| get_shape(char) }
        res += score_game(other, you) + SHAPE_POINTS[you]
      end
      res
    end

    def part2
      res = 0
      @input.split("\n").map do |line|
        chars = line.split
        other = chars.map { |char| get_shape(char) }.first
        you = pick_shape_on_strategy(chars.last, other)
        res += score_game(other, you) + SHAPE_POINTS[you]
      end
      res
    end
  end
end
