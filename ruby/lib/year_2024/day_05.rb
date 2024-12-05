# frozen_string_literal: true

module Year2024
  class Day05 < AdventOfCode::PuzzleBase
    def part1
      valid_instructions = @instructions.filter_map do |instruction|
        new_instruction = reorder_instruction(instruction)
        new_instruction == instruction ? new_instruction : nil
      end

      valid_instructions.collect do |instruction|
        instruction[instruction.length / 2]
      end.sum
    end

    def part2
      fixed = @instructions.filter_map do |instruction|
        new_instruction = reorder_instruction(instruction)
        new_instruction == instruction ? nil : new_instruction
      end

      fixed.collect do |instruction|
        instruction[instruction.length / 2]
      end.sum
    end

    private

    # setup gets called as part of initialize
    # input is available as the raw input string
    def setup
      raw_directions = @input.split("\n\n")
      @rules = {}
      raw_directions[0].split("\n").map do |rule|
        parsed_rule = rule.split('|').map(&:to_i)
        if @rules[parsed_rule[1]]
          @rules[parsed_rule[1]] << parsed_rule[0]
        else
          @rules[parsed_rule[1]] = Set.new([parsed_rule[0]])
        end
        @rules[parsed_rule[0]] = Set.new unless @rules[parsed_rule[0]]
      end

      @instructions = raw_directions[1].split("\n").map do |instruction|
        instruction.split(',').map(&:to_i)
      end
    end

    def reorder_instruction(instruction)
      length = instruction.length
      new_instruction = []
      instruction.each_with_index do |i, idx|
        next if new_instruction.include?(i)

        future_errors = instruction.slice(idx, length) & @rules[i].to_a
        new_instruction += reorder_instruction(future_errors) - new_instruction
        new_instruction << i
      end
      new_instruction
    end
  end
end
