# frozen_string_literal: true

module Year2022
  class Day11 < AdventOfCode::PuzzleBase
    def initialize(**args)
      super(**args)
      @monkeys = {}
      parse_monkeys
    end

    def part1
      20.times do |_i|
        @monkeys.each do |_monkey_n, monkey|
          run_monkey(monkey, divide_by_three: true)
        end
      end
      vals = @monkeys.values.collect { |monkey| monkey[:items_inspected] }.sort.last(2).flatten
      vals[0] * vals[1]
    end

    def part2
      10_000.times do |_i|
        @monkeys.each do |_monkey_n, monkey|
          run_monkey(monkey)
        end
      end
      vals = @monkeys.values.collect { |monkey| monkey[:items_inspected] }.sort.last(2).flatten
      vals[0] * vals[1]
    end

    private

    def run_monkey(monkey, divide_by_three: false)
      monkey[:items].each do |item|
        monkey[:items_inspected] += 1
        item = run_operation(item, monkey[:operation_type], monkey[:operation_value])

        if divide_by_three
          item /= 3 if divide_by_three
        else
          item %= @monkeys.map { |_monkey_n, m| m[:divide_by] }.inject(:*)
        end

        monkey_to_pass = (item % monkey[:divide_by]).zero? ? monkey[:true_monkey] : monkey[:false_monkey]

        @monkeys[monkey_to_pass][:items] << item
      end

      monkey[:items] = []
    end

    def run_operation(item, operation_type, operation_value, skip_self: false)
      return if skip_self && operation_value == :self

      value = operation_value == :self ? item : operation_value
      case operation_type
      when 'add'
        item += value
      when 'multiply'
        item = 1 if item.zero?
        item *= value
      end
      item
    end

    def parse_monkeys
      @input.split("\n\n").each do |input_block|
        parse_monkey(input_block)
      end
    end

    def monkey_items
      @monkeys.transform_values { |monkey| monkey[:items] }
    end

    def parse_monkey(input_block)
      monkey_row, items_row, operation_string, test_string, true_res, false_res = input_block.split("\n")
      monkey_n = monkey_row.split.last.gsub(':', '')
      monkey_items = items_row.split(': ').last.split(', ').map(&:to_i)

      operation_value = operation_string.split.last.to_i
      @monkeys[monkey_n] = {
        items: monkey_items,
        operation_type: operation_string.include?('+') ? 'add' : 'multiply',
        operation_value: operation_value.zero? ? :self : operation_value,
        divide_by: test_string.split(' divisible by ').last.to_i,
        true_monkey: true_res.split.last,
        false_monkey: false_res.split.last,
        items_inspected: 0
      }
    end
  end
end
