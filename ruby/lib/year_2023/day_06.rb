# frozen_string_literal: true

module Year2023
  class Day06 < AdventOfCode::PuzzleBase
    def part1
      winning_distances = @races.collect do |race|
        times = find_best_charging_times(race[:race_time], race[:record_distance])
        times[:max] - times[:min] + 1
      end
      winning_distances.inject(&:*)
    end

    def part2
      actual_time = @races.collect { |race| race[:race_time].to_s }.join.to_i
      actual_distance = @races.collect { |race| race[:record_distance].to_s }.join.to_i
      times = find_best_charging_times(actual_time, actual_distance)
      times[:max] - times[:min] + 1
    end

    def find_best_charging_times(max_time, record_distance)
      res = {}
      time = 0
      while res[:min].nil?
        res[:min] = time if time * (max_time - time) > record_distance
        time += 1
      end

      time = max_time
      while res[:max].nil?
        res[:max] = time if time * (max_time - time) > record_distance
        time -= 1
      end
      res
    end

    def setup
      times, distances = @input.split("\n").map(&:chomp)
      times = times.split(':').last.split.compact.map(&:to_i)
      distances = distances.split(':').last.split.compact.map(&:to_i)
      @races = times.collect.with_index { |t, i| { race_time: t, record_distance: distances[i] } }
    end
  end
end
