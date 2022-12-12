# frozen_string_literal: true

module Year2022
  class Day12 < AdventOfCode::PuzzleBase
    def initialize(*args)
      super(*args)
      parse_grid
    end

    def part1
      start, visited = run_search! { |node| part1_done?(node) }
      length(visited, start)
    end

    def part2
      start, visited = run_search! { |node| part2_done?(node) }
      length(visited, start)
    end

    private

    def part1_done?(node)
      node == @start.join(',')
    end

    def part2_done?(node)
      x, y = node.split(',').map(&:to_i)
      (@grid[x][y]).zero?
    end

    def run_search!
      visited = { @end.join(',') => nil }
      queue = [@end.join(',')]
      until queue.empty?
        current_node = queue.shift
        return current_node, visited if yield(current_node)

        next_nodes = available_nodes(current_node)
        next_nodes.map! do |node|
          unless visited.keys.include?(node.join(','))
            visited[node.join(',')] = current_node
            queue << node.join(',')
          end
        end
      end
    end

    def length(visited, start_node)
      trail_length = 0
      node = visited[start_node]
      while node
        node = visited[node]
        trail_length += 1
      end
      trail_length
    end

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
      @grid = @input.split("\n").each_with_index.map do |row_chars, row|
        chars = row_chars.chars
        @start ||= chars.find_index('S') ? [row, chars.find_index('S')] : nil
        @end ||= chars.find_index('E') ? [row, chars.find_index('E')] : nil
        chars.map do |char|
          char = 'a' if char == 'S'
          char = 'z' if char == 'E'
          ('a'..'z').to_a.find_index(char)
        end
      end
    end
  end
end
