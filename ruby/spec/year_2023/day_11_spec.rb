# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2023::Day11 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(year: 2023, day: 11).part1).to eq(374)
    end
  end

  describe 'part2' do
    it 'solves part2 - size 10' do
      expect(puzzle_test_runner(year: 2023, day: 11, override_args: { size: 10 }).part2).to eq(1030)
    end

    it 'solves part2 - size 100' do
      expect(puzzle_test_runner(year: 2023, day: 11, override_args: { size: 100 }).part2).to eq(8410)
    end
  end
end
