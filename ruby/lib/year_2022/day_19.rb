# frozen_string_literal: true

module Year2022
  class Day19 < AdventOfCode::PuzzleBase
    def part1
      binding.pry
    end

    private

    def buy_most_advanced_strategy(recipe)
      game = Day19Game.new(recipe)

      while game.minutes > 0
        if game.can_buy_geode_robot?
          game.buy_geode_robot
        elsif game.can_buy_obsidian_robot?
          game.buy_obsidian_robot
        elsif game.can_buy_clay_robot?
          game.buy_clay_robot
        elsif game.can_buy_ore_robot?
          game.buy_ore_robot
        end
        game.tick
      end
      game
    end

    def setup
      @recipes = {}
      @input.split("\n").map { |r| parse_recipe(r) }
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
        ore_robot_ore_cost:,
        clay_robot_ore_cost:,
        obsidian_robot_ore_cost:,
        obsidian_robot_clay_cost:,
        geode_robot_ore_cost:,
        geode_robot_obsidian_cost:
      }
    end
  end

  class Day19Game
    attr_accessor :recipe, :building, :robots, :resources, :minutes

    MINUTES = 24

    def initialize(recipe)
      @recipe = recipe
      @building = {
          ore: 0,
          clay: 0,
          obsidian: 0,
          geodes: 0
        }
      @robots = {
          ore: 1,
          clay: 0,
          obsidian: 0,
          geodes: 0
        }
      @resources = {
          ore: 0,
          clay: 0,
          obsidian: 0,
          geodes: 0
        }
      @minutes = MINUTES
    end

    def can_buy_ore_robot?
      resources[:ore] >= recipe[:ore_robot_ore_cost]
    end

    def can_buy_clay_robot?
      resources[:ore] >= recipe[:clay_robot_ore_cost]
    end

    def can_buy_obsidian_robot?
      resources[:ore] >= recipe[:obsidian_robot_ore_cost] &&
        resources[:clay] >= recipe[:obsidian_robot_clay_cost]
    end

    def can_buy_geode_robot?
      resources[:ore] >= recipe[:geode_robot_ore_cost] &&
        resources[:obsidian] >= recipe[:geode_robot_obsidian_cost]
    end

    def buy_ore_robot
      resources[:ore] -= recipe[:ore_robot_ore_cost]
      building[:ore] += 1
    end

    def buy_clay_robot
      resources[:ore] -= recipe[:clay_robot_ore_cost]
      building[:clay] += 1
    end

    def buy_obsidian_robot
      resources[:ore] -= recipe[:obsidian_robot_ore_cost]
      resources[:clay] -= recipe[:obsidian_robot_clay_cost]
      building[:obsidian] += 1
    end

    def buy_geode_robot
      resources[:ore] -= recipe[:geode_robot_ore_cost]
      resources[:obsidian] -= recipe[:geode_robot_obsidian_cost]
      building[:geodes] += 1
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
