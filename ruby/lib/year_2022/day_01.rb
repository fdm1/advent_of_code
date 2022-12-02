# frozen_string_literal: true

module Year2022
  class Day01 < PuzzleBase
    def part1
      current_max = 0
      elf_loads = parse_elf_loads

      elf_loads.each do |load|
        current_max = load if load > current_max
      end
      current_max
    end

    def part2
      elf_loads = parse_elf_loads
      elf_loads.sort!
      elf_loads.reverse!
      elf_loads[0..2].sum
    end

    def parse_elf_loads
      loads = []
      current_elf = 0
      input = @input.split("\n")
      input.each do |num|
        if num == ''
          loads << current_elf
          current_elf = 0
        else
          current_elf += num.to_i
        end
      end
      loads << current_elf
      loads
    end
  end
end
