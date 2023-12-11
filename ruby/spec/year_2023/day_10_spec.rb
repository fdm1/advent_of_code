# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2023::Day10 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(year: 2023, day: 10).part1).to eq(4)
    end

    it 'solves part1 - longer' do
      expect(puzzle_test_runner(year: 2023, day: 10, suffix: 'longer').part1).to eq(8)
    end
  end

  describe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(year: 2023, day: 10, suffix: 'part2_short').part2).to eq(4)
    end

    it 'solves part2 - short squeeze' do
      expect(puzzle_test_runner(year: 2023, day: 10, suffix: 'part2_short_squeeze').part2).to eq(4)
    end

    it 'solves part2 - longer' do
      expect(puzzle_test_runner(year: 2023, day: 10, suffix: 'part2_longer').part2).to eq(8)
    end

    it 'solves part2 - longest' do
      expect(puzzle_test_runner(year: 2023, day: 10, suffix: 'part2_longest').part2).to eq(10)
    end
  end
end
