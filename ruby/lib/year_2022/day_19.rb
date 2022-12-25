# frozen_string_literal: true

module Year2022
  class Day19 < AdventOfCode::PuzzleBase
    def part1
      @recipes.keys.collect do |r|
        %i[ore clay obsidian geode].permutation.collect do |p|
          game = Day19Game.new(recipe: @recipes[r], purchase_order: p)
          buy_and_tick(game) until game.minutes.zero?
          # puts "Game: #{game.recipe_id} - #{p} - #{game.value}"
          game.value
        end.max
      end.sum
    end

    private

    def buy_and_tick(game)
      # puts "BUYING #{game.recommended_robot} (
      recommended = game.recommended_robot
      buy_string = recommended ? "buy #{recommended}" : 'do nothing'
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

    def initialize(recipe:, minutes: MINUTES, building: nil, robots: nil, resources: nil, purchase_order: [])
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
      @purchase_order = purchase_order
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

      return false if robots[:clay] >= recipe[:obsidian][:costs][:clay]

      !cannot_buy_b_if_buy_a?(:clay, :obsidian, 5) &&
        !cannot_buy_b_if_buy_a?(:clay, :geode, 5)
    end

    def should_buy_ore?
      return false unless can_buy_robot?(:ore)

      return false unless !cannot_buy_b_if_buy_a?(:ore, :obsidian, 5) &&
                          !cannot_buy_b_if_buy_a?(:ore, :geode, 5)

      robots[:ore] < [
        recipe[:clay][:costs][:ore],
        recipe[:obsidian][:costs][:ore],
        recipe[:geode][:costs][:ore]
      ].max
    end

    def should_buy_robot?(type)
      case type
      when :ore
        should_buy_ore?
      when :clay
        should_buy_clay?
      when :obsidian
        should_buy_obsidian?
      when :geode
        can_buy_robot?(:geode)
      end
    end

    def recommended_robot
      @purchase_order.each do |type|
        return type if should_buy_robot?(type)
      end
      nil
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
