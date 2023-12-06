# frozen_string_literal: true

module Year2023
  class Day02 < AdventOfCode::PuzzleBase
    LIMITS = {
      red: 12,
      green: 13,
      blue: 14
    }.freeze

    def part1
      valid_games = @games.filter do |_game_number, rounds|
        rounds.none? do |round|
          round.any? do |color, number|
            number > LIMITS[color]
          end
        end
      end
      valid_games.keys.sum
    end

    def part2
      @games.collect do |_game_number, rounds|
        game_power(rounds)
      end.sum
    end

    def setup
      @games = @input.split("\n").to_h do |game|
        parse_game(game)
      end
    end

    def parse_game(game)
      halves = game.split(':').map(&:strip)
      game_number = halves[0].split[1].to_i
      rounds = halves[1].split('; ')
      [game_number, rounds.collect { |round| parse_round(round) }]
    end

    def parse_round(round)
      colors = round.split(', ')
      colors.to_h do |color_string|
        number_and_color = color_string.split
        number = number_and_color[0]
        color = number_and_color[1]
        [color.to_sym, number.to_i]
      end
    end

    def game_power(parsed_game)
      mins = { red: 0, green: 0, blue: 0 }
      parsed_game.each do |round|
        round.each do |color, number|
          mins[color] = number if number > mins[color]
        end
      end
      mins.values.reduce(:*)
    end
  end
end
