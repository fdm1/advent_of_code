# frozen_string_literal: true

module Year2022
  class Day09 < AdventOfCode::PuzzleBase
    def initialize(input)
      super(input)
      @tails = []
      @head = [0, 0]
      @tail_positions = Set.new
    end

    def part1
      @tails = [[0, 0]]
      process_input
    end

    def part2
      @tails = 9.times.collect { [0, 0] }
      process_input
    end

    private

    def process_input
      @input.split("\n").each do |row|
        direction, spaces = row.split
        move_head(direction, spaces)
      end
      @tail_positions.length
    end

    def draw
      puts("\n\n")
      spaces = [@head] + @tails
      min_x = (spaces.collect(&:first) + @tail_positions.collect { |i| i.split(',')[0].to_i }).min - 4
      max_x = (spaces.collect(&:first) + @tail_positions.collect { |i| i.split(',')[0].to_i }).max + 4
      min_y = (spaces.collect(&:last) + @tail_positions.collect { |i| i.split(',')[-1].to_i }).min - 4
      max_y = (spaces.collect(&:last) + @tail_positions.collect { |i| i.split(',')[-1].to_i }).max + 4
      (min_y..max_y).to_a.reverse.each do |y|
        (min_x..max_x).each do |x|
          if @head == [x, y]
            print 'H'
          elsif @tail_positions.include?([x, y].join(','))
            print '#' # 'X'
          elsif @tails.include?([x, y])
            print @tails.find_index([x, y]) + 1
          else
            print '.'
          end
        end
        puts
      end
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
