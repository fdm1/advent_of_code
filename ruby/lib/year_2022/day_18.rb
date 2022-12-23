# frozen_string_literal: true

module Year2022
  class Day18 < AdventOfCode::PuzzleBase
    def part1
      count_sides(@cubes, @grids)
      @cubes.sum { |c| c[:open_faces] }
    end

    def part2
      spots_to_check = @cubes.collect { |c| open_adjacent_points(*c[:coords]) }.flatten(1).uniq
      spots_to_check.reject! { |c| is_outer_cube?(*c) }

      open_points = Set.new(points_outside)
      closed_points = Set.new
      @cubes.each_with_index do |cube, i|
        puts "Checking #{cube[:coords]} (#{i}/#{@cubes.length})" if @debug
        cube[:outer_faces] = 0
        adjacent_coords = open_adjacent_points(*cube[:coords])

        adjacent_coords.map do |p|
          point_cubes = Set.new
          bfs = AdventOfCode::Algorithms::BFS.new(
            end_node: p,
            starting_nodes: points_outside,
            bad_nodes: closed_points
          )
          # binding.pry if i == 5
          bfs.run_search! { |point| open_adjacent_points(*point) }
          if bfs.distance
            open_points.merge(bfs.nodes_visited)
            cube[:outer_faces] += 1
          else
            closed_points.merge(bfs.nodes_visited)
          end
        end
      end

      @cubes.sum { |c| c[:outer_faces] }
    end

    private

    def points_outside
      top = @cubes.max_by { |c| c[:z] }[:coords]
      bottom = @cubes.min_by { |c| c[:z] }[:coords]
      left = @cubes.min_by { |c| c[:x] }[:coords]
      right = @cubes.max_by { |c| c[:x] }[:coords]
      forward = @cubes.min_by { |c| c[:y] }[:coords]
      back = @cubes.max_by { |c| c[:y] }[:coords]
      [
        [top[0], top[1], top[2] + 1],
        [bottom[0], bottom[1], bottom[2] - 1],
        [left[0] - 1, left[1], left[2]],
        [right[0] + 1, right[1], right[2]],
        [forward[0], forward[1] - 1, forward[2]],
        [back[0], back[1] + 1, back[2]]
      ]
    end

    def is_outer_cube?(x, y, z)
      @cubes.none? { |c| c[:x] == x && c[:y] == y && c[:z] > z } ||
        @cubes.none? { |c| c[:x] == x && c[:y] == y && c[:z] < z } ||
        @cubes.none? { |c| c[:x] < x && c[:y] == y && c[:z] == z } ||
        @cubes.none? { |c| c[:x] > x && c[:y] == y && c[:z] == z } ||
        @cubes.none? { |c| c[:x] == x && c[:y] < y && c[:z] == z } ||
        @cubes.none? { |c| c[:x] == x && c[:y] > y && c[:z] == z }
    end

    def open_adjacent_points(x, y, z)
      [
        [x - 1, y, z],
        [x + 1, y, z],
        [x, y - 1, z],
        [x, y + 1, z],
        [x, y, z - 1],
        [x, y, z + 1]
      ].filter { |p| @cubes.none? { |c| c[:coords] == p } }
    end

    def count_sides(cubes, grids)
      cubes.each.sum do |cube|
        res = 0
        res += grids[:xy][cube[:z]][cube[:xy]] == 1 ? 1 : 0
        res += grids[:xz][cube[:y]][cube[:xz]] == 1 ? 1 : 0
        res += grids[:yz][cube[:x]][cube[:yz]] == 1 ? 1 : 0
        res += grids[:xy][cube[:z] + 1][cube[:xy]] == 1 ? 1 : 0
        res += grids[:xz][cube[:y] + 1][cube[:xz]] == 1 ? 1 : 0
        res += grids[:yz][cube[:x] + 1][cube[:yz]] == 1 ? 1 : 0
        cube[:open_faces] = res
      end
    end

    def create_cube(x, y, z)
      xy = [[x, x - 1].sort, [y, y - 1].sort]
      xz = [[x, x - 1].sort, [z, z - 1].sort]
      yz = [[y, y - 1].sort, [z, z - 1].sort]

      { xy:, xz:, yz:, x:, y:, z:, coords: [x, y, z] }
    end

    def build_grid(cubes)
      grids = {
        xy: {},
        xz: {},
        yz: {}
      }
      cubes.each do |cube|
        x = cube[:x]
        y = cube[:y]
        z = cube[:z]
        xy = cube[:xy]
        xz = cube[:xz]
        yz = cube[:yz]
        grids[:xy][z] ||= {}
        grids[:xz][y] ||= {}
        grids[:yz][x] ||= {}
        grids[:xy][z + 1] ||= {}
        grids[:xz][y + 1] ||= {}
        grids[:yz][x + 1] ||= {}

        grids[:xy][z][xy] = grids[:xy][z][xy].nil? ? 1 : grids[:xy][z][xy] + 1
        grids[:xz][y][xz] = grids[:xz][y][xz].nil? ? 1 : grids[:xz][y][xz] + 1
        grids[:yz][x][yz] = grids[:yz][x][yz].nil? ? 1 : grids[:yz][x][yz] + 1
        grids[:xy][z + 1][xy] = grids[:xy][z + 1][xy].nil? ? 1 : grids[:xy][z + 1][xy] + 1
        grids[:xz][y + 1][xz] = grids[:xz][y + 1][xz].nil? ? 1 : grids[:xz][y + 1][xz] + 1
        grids[:yz][x + 1][yz] = grids[:yz][x + 1][yz].nil? ? 1 : grids[:yz][x + 1][yz] + 1
      end

      grids
    end

    def setup
      @grids = {
        xy: {},
        xz: {},
        yz: {}
      }
      @cubes = @input.split("\n").collect do |line|
        create_cube(*line.split(',').map(&:to_i))
      end

      @grids = build_grid(@cubes)
    end
  end
end
