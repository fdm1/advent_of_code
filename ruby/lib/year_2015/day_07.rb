# frozen_string_literal: true

module Year2015
  class Day07 < AdventOfCode::PuzzleBase
    attr_accessor :wires

    def part1(input = @input_rows)
      process_input(input) while @processed_rows.count != input.count

      puts "a: #{wires['a']}\n"

      wires
    end

    def part2
      part1

      @processed_rows = []
      new_input = @input_rows.collect do |row|
        row.end_with?('-> b') ? "#{wires['a']} -> b" : row
      end
      @wires = {}
      part1(new_input)
    end

    private

    def setup
      @wires = {}
      @input_rows = @input.split("\n")
      @processed_rows = []
    end

    def process_input(input)
      input.each do |row|
        process_row(row)
      end
    end

    def process_row(row)
      direction, target = row.split(' -> ')
      direction = direction.split
      return if @processed_rows.include?(row)
      return if direction.select { |d| d.match(/[a-z]/) }.any? { |w| wires[w].nil? }

      if direction.count == 1
        wires[target] = wires[direction.last] || direction.last.to_i # assign
        @processed_rows << row
        return
      else
        bitwise_ops(row)
      end
      @processed_rows << row
    end

    def bitwise_ops(row)
      direction, target = row.split(' -> ')
      direction = direction.split

      if direction.first == 'NOT'
        val = ~wires[direction.last].to_s.to_i
        wires[target] = val.negative? ? 65_536 + val : val
      end

      left = wires[direction.first] || direction.first.to_i
      right = wires[direction.last] || direction.last.to_i
      case direction[1]
      when 'AND'
        wires[target] = left & right
      when 'OR'
        wires[target] = left | right
      when 'LSHIFT'
        wires[target] = left << right
      when 'RSHIFT'
        wires[target] = left >> right
      end
    end
  end
end
