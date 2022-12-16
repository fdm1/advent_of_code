# frozen_string_literal: true

module Year2022
  class Day16 < AdventOfCode::PuzzleBase
    MAX_TIME = 30

    def part1
      find_path_alone
    end

    def part2
      find_path_together
    end

    private

    def score_path(next_valve:, current_score:, time_remaining:, path:)
      current_valve = path.last
      distance = @valves[current_valve][:tunnel_distances][next_valve]
      return if next_valve == current_valve || distance.nil? || (time_remaining - distance).negative?

      new_time_remaining = time_remaining - (distance + 1)
      new_score = current_score + (@valves[next_valve][:flow_rate] * new_time_remaining)

      { path: path + [next_valve], current_score: new_score, time_remaining: new_time_remaining }
    end

    def find_path_alone
      queue = []
      iteration = 0
      best_path = { path: ['AA'], current_score: 0, time_remaining: MAX_TIME }
      queue << best_path

      until queue.empty?
        iteration += 1
        path = queue.shift
        best_path = path if path[:current_score] > best_path[:current_score]
        valves_to_open.each do |valve|
          next if path[:path].include?(valve)

          new_path = score_path(next_valve: valve, **path)
          queue << new_path if new_path
        end
      end
      best_path[:current_score]
    end

    def find_path_together
      queue = []
      iteration = 0
      best_paths = { paths: [
        { path: ['AA'], current_score: 0, time_remaining: MAX_TIME - 4 },
        { path: ['AA'], current_score: 0, time_remaining: MAX_TIME - 4 }

      ], valves_left: valves_to_open, score: 0 }
      queue << best_paths

      until queue.empty?
        iteration += 1
        next_item = queue.shift
        paths = next_item[:paths]
        best_paths = next_item if paths.sum { |p| p[:current_score] } > best_paths[:paths].sum { |p| p[:current_score] }

        valves_remaining = next_item[:valves_left]
        next if valves_remaining.empty?

        if (iteration % 10_000).zero? && @debug
          path_counts = "(#{paths.first[:path].length}-#{paths.last[:path].length})"
          puts "Iteration #{iteration} (valves_remaining.count: #{valves_remaining.count}) #{path_counts}"
        end
        valves_remaining.each do |first_valve|
          first_new_path = score_path(next_valve: first_valve, **paths.first)
          first_path = first_new_path || paths.first
          valves_remaining.each do |second_valve|
            next if first_valve == second_valve

            second_new_path = score_path(next_valve: second_valve, **paths.last)
            second_path = second_new_path || paths.last

            next unless first_new_path || second_new_path

            new_paths = [first_path, second_path]
            max_time_remaining = new_paths.max_by { |p| p[:time_remaining] }[:time_remaining]
            valves_left = (valves_remaining - [first_valve, second_valve])
            new_score = new_paths.sum { |p| p[:current_score] }
            valves_left.filter! do |v|
              min_distance = [@valves[v][:tunnel_distances][first_valve],
                              @valves[v][:tunnel_distances][second_valve]].min
              not_too_far = max_time_remaining - min_distance >= 0
              not_too_small = (new_score + (@valves[v][:flow_rate] * max_time_remaining)) >= best_paths[:score]
              not_too_far && not_too_small
            end
            next unless new_paths.all?

            queue << { paths: new_paths, valves_left:, score: new_paths.sum do |p|
                                                                p[:current_score]
                                                              end }
          end
        end
      end

      best_paths[:score]
    end

    def valves_to_open
      @valves.sort_by { |_k, v| v[:flow_rate] }.reverse.filter { |v| !v[1][:flow_rate].zero? }.collect { |v| v[0] }
    end

    def setup
      @valves = {}
      @input.split("\n").map do |row|
        data = /^Valve (\S*) has flow rate=(\d+); tunnels? leads? to valves? (.*)$/.match(row)
        valve = data[1]
        flow_rate = data[2].to_i
        tunnels = data[3].split(', ')
        @valves[valve] = { flow_rate:, tunnels: }
      end
      build_valve_distances
    end

    def build_valve_distances
      @valves.keys.collect do |valve|
        valve_tunnel_distances = {}
        @valves.keys.map do |tunnel|
          next if tunnel == valve

          distance = AdventOfCode::Algorithms::BFS.new(endpoint: valve, starting_points: [tunnel]).run_search! do |v|
            @valves[v][:tunnels].dup
          end
          valve_tunnel_distances[tunnel] = distance
          @valves[valve][:tunnel_distances] = valve_tunnel_distances if distance.positive? || tunnel == 'AA'
        end
      end
    end
  end
end
