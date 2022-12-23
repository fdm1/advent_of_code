# frozen_string_literal: true

module Year2022
  class Day19 < AdventOfCode::PuzzleBase
    def part1
      find_solution
      puts @best_games
      @best_games.max_by { |k, v| v[:value] }.last[:value]
    end

    private

    def find_solution
      @all_games = []
      game_queue = @recipes.keys.collect { |r| Day19Game.new(recipe: @recipes[r])}
      iterations = 0
      while game_queue.any?
        iterations += 1
        game = game_queue.shift
        next if game.nil?
        recipe_id = game.recipe_id

        # puts "#{game}" if iterations % 1000 == 0
        # puts "game #{recipe_id} - #{game.minutes} - #{game.resources[:geode]}" if game.resources[:geode] > 0
        game.tick
        binding.pry if iterations == 1
        if game.minutes > 2
          # obsidian_game = buy_obsidian(copy_game(game))

          game_queue << buy_most_advanced_strategy(copy_game(game))
          game_queue << buy_clay(copy_game(game))
          game_queue << buy_obsidian(copy_game(game))
          game_queue << buy_advanced(copy_game(game))
          # game_queue << obsidian_game if obsidian_game
          #
          # game_queue << advanced_game if advanced_game
        end
        # binding.pry if game_queue.any? {|g| g.is_a?(Integer)}
        if game.minutes > 0
          game_queue << game  # do nothing
        else
          @all_games << game
          @best_games[recipe_id] = {value: game.value, geode: game.resources[:geode]} if game.value > @best_games[recipe_id][:value]
        end
      end
    end

    def copy_game(game)
      Day19Game.new(recipe: game.recipe, resources: game.resources.dup, robots: game.robots.dup, minutes: game.minutes)
    end

    def buy_clay(game)
      return unless game.can_buy_robot?(:clay)
      game.buy_robot_type(:clay)
      game
    end

    def buy_obsidian(game)
      return unless game.can_buy_robot?(:obsidian)
      game.buy_robot_type(:obsidian)
      game
    end

    def buy_advanced(game)
      return unless game.can_buy_robot?(:geode) || game.can_buy_robot?(:obsidian)
      game.buy_most_advanced_robot
      game
    end

    def buy_most_advanced_strategy(game)
      while game.minutes > 0
        game.buy_most_advanced_robot
        game.tick
      end
      game
    end

    def setup
      @recipes = {}
      @input.split("\n").map { |r| parse_recipe(r) }
      @best_games = @recipes.keys.collect { |r| [r, {value: 0}] }.to_h
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
        robots: {
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
      }
    end
  end

  class Day19Game
    attr_accessor :recipe, :building, :robots, :resources, :minutes, :value, :recipe_id

    MINUTES = 24

    def initialize(recipe:, minutes: MINUTES, building: nil, robots: nil, resources: nil)
      @recipe = recipe
      @building = building || {
          ore: 0,
          clay: 0,
          obsidian: 0,
          geode: 0
        }
      @robots = robots ||{
          ore: 1,
          clay: 0,
          obsidian: 0,
          geode: 0
        }
      @resources = resources ||{
          ore: 0,
          clay: 0,
          obsidian: 0,
          geode: 0
        }
      @minutes = minutes
    end

    def to_s
      "recipe: #{recipe_id} - minutes: #{minutes} - resources: #{resources} - value: #{value}"
    end

    def recipe_id
      recipe[:id]
    end

    def value
      resources[:geode] * recipe[:id] if minutes == 0
    end

    def can_buy_any_robot?
      can_buy_robot?(:geode) ||
        can_buy_robot?(:obsidian) ||
        can_buy_robot?(:clay) ||
        can_buy_robot?(:ore)
    end

    def can_buy_robot?(type)
      recipe[:robots][type][:costs].each do |cost_type, cost_value|
        return false if resources[cost_type] < cost_value
      end
    end

    def most_advanced_robot_can_afford
      if can_buy_robot?(:geode)
        :geode
      elsif can_buy_robot?(:obsidian)
        :obsidian
      elsif can_buy_robot?(:clay)
        :clay
      elsif can_buy_robot?(:ore)
        :ore
      end
    end

    def buy_next_most_advanced_robot
      if can_buy_robot?(:geode) && can_buy_robot?(:obsidian)
        buy_robot_type(:obsidian)
      elsif can_buy_robot?(:obsidian) && can_buy_robot?(:clay)
        buy_robot_type(:clay)
      elsif can_buy_robot?(:clay) && can_buy_robot?(:ore)
        buy_robot_type(:ore)
      end
    end

    def buy_least_advanced_robot
      buy_robot_type(:ore) ||
        buy_robot_type(:clay) ||
        buy_robot_type(:obsidian) ||
        buy_robot_type(:geode)
    end

    def buy_most_advanced_robot
      buy_robot_type(:geode) ||
        buy_robot_type(:obsidian) ||
        buy_robot_type(:clay) ||
        buy_robot_type(:ore)
    end

    def buy_robot_type(type)
      return unless can_buy_robot?(type) && minutes > 0
      recipe[:robots][type][:costs].each do |cost_type, cost_value|
        resources[cost_type] -= cost_value
      end
      building[type] += 1
    end

    def finish_building
      building.keys.each do |type|
        if building[type] > 0
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

    def tick
      if minutes > 0
        collect_resources
        finish_building
        self.minutes -= 1
      end
    end
  end
end
