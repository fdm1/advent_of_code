# frozen_string_literal: true

module Year2022
  class Day12 < AdventOfCode::PuzzleBase
    def initialize(*args)
      super(*args)
      parse_grid
    end

    def part1
      bfs = AdventOfCode::Algorithms::BFS.new(endpoint: @end.join(','), starting_points: [@start.join(',')])
      bfs.run_search! { |node| available_nodes(node) }
    end

    def part2
      bfs = AdventOfCode::Algorithms::BFS.new(endpoint: @end.join(','), starting_points: @low_points)
      bfs.run_search! { |node| available_nodes(node) }
    end

    private

    def available_nodes(node)
      x, y = node.split(',').map(&:to_i)
      height = @grid[x][y]
      nodes = []
      nodes << [x - 1, y] if x.positive?
      nodes << [x + 1, y] if x < @grid.size - 1
      nodes << [x, y - 1] if y.positive?
      nodes << [x, y + 1] if y < @grid.first.size - 1
      nodes.filter { |grid_node| @grid[grid_node[0]][grid_node[1]] >= (height - 1) }
    end

    def parse_grid
      @low_points = []
      @grid = @input.split("\n").each_with_index.map do |row_chars, x|
        chars = row_chars.chars
        chars.each_with_index.map do |char, y|
          @start ||= char == 'S' ? [x, y] : nil
          @end ||= char == 'E' ? [x, y] : nil
          char = 'a' if char == 'S'
          char = 'z' if char == 'E'
          @low_points << [x, y].join(',') if char == 'a'
          ('a'..'z').to_a.find_index(char)
        end
      end
    end
  end
end
