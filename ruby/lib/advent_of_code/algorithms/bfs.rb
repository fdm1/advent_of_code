# frozen_string_literal: true

module AdventOfCode
  module Algorithms
    class BFS
      attr_reader :distance

      def initialize(end_node:, starting_nodes:, bad_nodes: [])
        @end_node = end_node
        @starting_nodes = starting_nodes
        @distance = nil
        @bad_nodes = bad_nodes
        @all_nodes_visited = []
        @visited = { @end_node => nil }
        @queue = [@end_node]
      end

      def run_search!
        raise ArgumentError, 'A block for finding the next nodes from a given node must be provided' unless block_given?

        @nodes_visited = nil

        until @queue.empty?
          current_node = @queue.shift
          return if @bad_nodes.include?(current_node)

          @all_nodes_visited << current_node
          if @starting_nodes.include?(current_node)
            @distance = length_from(current_node)
            return @distance
          end

          next_nodes = yield(current_node)
          return if next_nodes.any? { |n| @bad_nodes.include?(n) }
          @all_nodes_visited += next_nodes
          next_nodes.map! do |node|
            unless @visited.keys.include?(node)
              @visited[node] = current_node
              @queue << node
            end
          end
        end
      end

      def nodes_visited
        @nodes_visited ||= @all_nodes_visited.uniq
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
