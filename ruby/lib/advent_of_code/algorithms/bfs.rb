# frozen_string_literal: true

module AdventOfCode
  module Algorithms
    class BFS
      def initialize(endpoint:, starting_points:)
        @endpoint = endpoint
        @starting_points = starting_points
        @visited = { @endpoint => nil }
        @queue = [@endpoint]
      end

      def run_search!
        raise ArgumentError, 'A block for finding the next nodes from a given node must be provided' unless block_given?

        until @queue.empty?
          current_node = @queue.shift
          return length_from(current_node) if @starting_points.include?(current_node)

          next_nodes = yield(current_node)
          next_nodes.map! do |node|
            unless @visited.keys.include?(node)
              @visited[node] = current_node
              @queue << node
            end
          end
        end
      end

      private

      def length_from(start_node)
        trail_length = 0
        node = @visited[start_node]
        while node
          node = @visited[node]
          trail_length += 1
        end
        trail_length
      end
    end
  end
end
