# frozen_string_literal: true

module Year2022
  class Day19 < AdventOfCode::PuzzleBase
    def part1
      @recipes.keys.collect do |r|
        game = Day19Game.new(recipe: @recipes[r])
        buy_and_tick(game) until game.minutes.zero?
        game.value
      end.sum
    end

    private

    def buy_and_tick(game)
      # puts "BUYING #{game.recommended_robot} (
      buy_string = game.recommended_robot ? "buy #{game.recommended_robot}" : 'do nothing'
      if @debug && game.recipe_id == @debug_id
        puts
        puts "Minute #{game.minutes_elapsed} - #{buy_string}"
      end
      game.buy_robot_type(game.recommended_robot)
      game.tick
      puts game if @debug && game.recipe_id == @debug_id
    end

    def buy_recommended(game)
      next_type = game.recommended_robot
      return unless next_type

      # puts "buying recommended #{next_type}"
      game.buy_robot_type(next_type)
      game
    end

    def setup
      @recipes = {}
      @input.split("\n").map { |r| parse_recipe(r) }
      @best_games = @recipes.keys.to_h { |r| [r, { value: 0 }] }
      @debug_id = ENV.fetch('ID', -1).to_i
    end

    def parse_recipe(recipe_rows)
      pattern = /^\D*(\d+)\D*(\d+)\D*(\d+)\D*(\d+)\D*(\d+)\D*(\d+)\D*(\d+)\D*$/
      matches = recipe_rows.match(pattern)

      (
        recipe_n,
        ore_robot_ore_cost,
        clay_robot_ore_cost,
        obsidian_robot_ore_cost,
        obsidian_robot_clay_cost,
        geode_robot_ore_cost,
        geode_robot_obsidian_cost
      ) = matches.captures.map(&:to_i)

      @recipes[recipe_n] = {
        id: recipe_n,
        ore: {
          costs: {
            ore: ore_robot_ore_cost
          }
        },
        clay: {
          costs: {
            ore: clay_robot_ore_cost
          }

        },
        obsidian: {
          costs: {
            ore: obsidian_robot_ore_cost,
            clay: obsidian_robot_clay_cost
          }
        },
        geode: {
          costs: {
            ore: geode_robot_ore_cost,
            obsidian: geode_robot_obsidian_cost
          }
        }
      }
    end
  end

  class Day19Game
    attr_accessor :recipe, :building, :robots, :resources, :minutes

    MINUTES = 24

    def initialize(recipe:, minutes: MINUTES, building: nil, robots: nil, resources: nil)
      @recipe = recipe
      @building = building || {
        ore: 0,
        clay: 0,
        obsidian: 0,
        geode: 0
      }
      @robots = robots || {
        ore: 1,
        clay: 0,
        obsidian: 0,
        geode: 0
      }
      @resources = resources || {
        ore: 0,
        clay: 0,
        obsidian: 0,
        geode: 0
      }
      @minutes = minutes
    end

    def to_s
      [
        "- robots: #{robots.dup.keep_if { |_k, v| v.positive? }}",
        "- resources: #{resources.dup.keep_if { |_k, v| v.positive? }}"
      ].compact.join("\n")
    end

    def recipe_id
      recipe[:id]
    end

    def value
      resources[:geode] * recipe[:id] if minutes.zero?
    end

    def minutes_elapsed
      MINUTES - minutes + 1
    end

    # Blueprint 1 (9):
    #   Each ore robot costs 4 ore.
    #   Each clay robot costs 2 ore.
    #   Each obsidian robot costs 3 ore and 14 clay.
    #   Each geode robot costs 2 ore and 7 obsidian.
    #
    # Blueprint 2 (24 - 12 geodes):
    #   Each ore robot costs 2 ore.
    #   Each clay robot costs 3 ore.
    #   Each obsidian robot costs 3 ore and 8 clay.
    #   Each geode robot costs 3 ore and 12 obsidian.

    def cannot_buy_b_if_buy_a?(type_a, type_b, rounds = 1)
      game_that_buys_a = copy_game
      game_that_does_not_buy_a = copy_game
      game_that_buys_a.buy_robot_type(type_a)
      rounds.times do
        game_that_buys_a.tick
        game_that_does_not_buy_a.tick
        return true if !game_that_buys_a.can_buy_robot?(type_b) && game_that_does_not_buy_a.can_buy_robot?(type_b)
      end
      !game_that_buys_a.can_buy_robot?(type_b) && game_that_does_not_buy_a.can_buy_robot?(type_b)
    end

    def should_buy_obsidian?
      return false unless can_buy_robot?(:obsidian)

      !cannot_buy_b_if_buy_a?(:obsidian, :geode, 5)
    end

    def should_buy_clay?
      return false unless can_buy_robot?(:clay)

      # return false if (robots[:clay] + resources[:clay] >= recipe[:obsidian][:costs][:clay]
      # return false if recipe[:obsidian][:costs][:clay] <= robots[:clay] / 2
      !cannot_buy_b_if_buy_a?(:clay, :obsidian, 5)
    end

    def should_buy_ore?
      # return false if recipe_id == 2 && minutes_elapsed == 3
      return false unless can_buy_robot?(:ore)
      return false if robots[:ore] >= [
        recipe[:clay][:costs][:ore],
        recipe[:obsidian][:costs][:ore],
        recipe[:geode][:costs][:ore]
      ].max

      # return false if cannot_buy_b_if_buy_a?(:ore, :geode, 5)
      #
      # return false if  cannot_buy_b_if_buy_a?(:ore, :obsidian, 5)
      #   cannot_buy_b_if_buy_a?(:ore, :clay, 3)
      true
    end

    def recommended_robot
      # binding.pry if recipe_id == 2 && minutes_elapsed == 5

      return :geode if can_buy_robot?(:geode)
      return :obsidian if should_buy_obsidian?
      return :ore if should_buy_ore?
      return :clay if should_buy_clay?
    end

    def can_buy_robot?(type)
      recipe[type][:costs].all? do |cost_type, cost_value|
        cost_value <= resources[cost_type]
      end
    end

    def buy_robot_type(type)
      return unless type
      return unless can_buy_robot?(type)

      recipe[type][:costs].each do |cost_type, cost_value|
        resources[cost_type] -= cost_value
      end
      building[type] += 1
    end

    def finish_building
      building.each_key do |type|
        if building[type].positive?
          robots[type] += 1
          building[type] -= 1
        end
      end
    end

    def collect_resources
      robots.each do |type, value|
        resources[type] += value
      end
    end

    def copy_game
      Day19Game.new(recipe:, resources: resources.dup, robots: robots.dup, minutes: minutes.dup)
    end

    def tick
      return unless minutes.positive?

      collect_resources
      finish_building
      self.minutes -= 1
    end
  end
end
