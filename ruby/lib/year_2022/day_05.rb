# frozen_string_literal: true

module Year2022
  class Day05 < PuzzleBase
    def move_per_crate(n_times, from, to, stacks)
      n_times.times do |_i|
        stacks[to.to_s] << stacks[from.to_s].pop
      end

      stacks
    end

    def move_per_stack(n_crates, from, to, stacks)
      stacks[to.to_s] += stacks[from.to_s].pop(n_crates)
      stacks
    end

    def part1
      stacks = initial_stacks
      directions.each { |direction| stacks = move_per_crate(*(direction << stacks)) }
      stacks.values.map(&:last).join
    end

    def part2
      stacks = initial_stacks
      directions.each { |direction| stacks = move_per_stack(*(direction << stacks)) }
      stacks.values.map(&:last).join
    end

    private

    def directions
      @directions = @input.split("\n").filter { |line| line.include?('move') }.collect do |line|
        line.split.filter { |v| v.to_i != 0 }.map(&:to_i)
      end
    end

    def initial_stacks
      @initial_stacks ||= begin
        stacks = {}
        @input.split("\n").each do |line|
          break unless line.include?('[')

          line_stacks = line.chars.to_a.each_slice(4).map { |col| col.filter { |char| char in 'A'..'Z' } }
          line_stacks.each_with_index do |stack, i|
            stacks[(i + 1).to_s] ||= []
            stacks[(i + 1).to_s] << stack.first unless stack.empty?
          end
        end
        stacks.transform_values(&:reverse)
      end
    end
  end
end
