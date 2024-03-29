# frozen_string_literal: true

module Year2022
  class Day09 < AdventOfCode::PuzzleBase
    def part1
      @tails = [[0, 0]]
      process_input
    end

    def part2
      @tails = 9.times.collect { [0, 0] }
      process_input
    end

    private

    def setup
      @tails = []
      @head = [0, 0]
      @tail_positions = Set.new
    end

    def process_input
      @input.split("\n").each do |row|
        direction, spaces = row.split
        move_head(direction, spaces)
        # draw
      end
      @tail_positions.length
    end

    def draw
      special_points = { @head => 'H' }
      @tails.to_a.each_with_index { |tail, i| special_points[tail] = (i + 1).to_s }
      tail_positions = @tail_positions.to_a.map { |p| p.split(',').map(&:to_i) }
      AdventOfCode::GridDrawer.new(
        points: special_points.keys + tail_positions,
        special_points:
      ).draw
    end

    def move_head(direction, spaces)
      spaces.to_i.times do |_i|
        case direction
        when 'R'
          @head[0] += 1
        when 'L'
          @head[0] -= 1
        when 'U'
          @head[1] += 1
        when 'D'
          @head[1] -= 1
        end
        move_tail(@head, 0)

        @tail_positions.add(@tails.last.join(','))
      end
    end

    def move_tail(leader, tail_n)
      tail = @tails[tail_n]
      return unless tail

      # if not next to head, move tail
      if (tail[0] - leader[0]).abs > 1 || (tail[1] - leader[1]).abs > 1
        # if in same row
        if tail[0] == leader[0]
          # tail is right
          if tail[1] > leader[1]
            tail[1] -= 1
          # tail is left
          else
            tail[1] += 1
          end
        # if in same column
        elsif tail[1] == leader[1]
          # tail is above
          if tail[0] > leader[0]
            tail[0] -= 1
          # tail is below
          else
            tail[0] += 1
          end
        # below diag
        elsif leader[0] - tail[0] == 2
          tail[0] = leader[0] - 1
          if leader[1] > tail[1]
            tail[1] += 1
          else
            tail[1] -= 1
          end
        # above diag
        elsif tail[0] - leader[0] == 2
          tail[0] = leader[0] + 1
          if leader[1] > tail[1]
            tail[1] += 1
          else
            tail[1] -= 1
          end
        # right diag
        elsif leader[1] - tail[1] == 2
          tail[1] = leader[1] - 1
          if leader[0] > tail[0]
            tail[0] += 1
          else
            tail[0] -= 1
          end
        # left diag
        elsif tail[1] - leader[1] == 2
          tail[1] = leader[1] + 1
          if leader[0] > tail[0]
            tail[0] += 1
          else
            tail[0] -= 1
          end
        end
      end
      move_tail(tail, tail_n + 1)
    end
  end
end
