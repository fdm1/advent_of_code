# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day17 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(year: 2022, day: 17).part1).to eq(3068)
    end
  end

  describe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(year: 2022, day: 17,
                                override_args: { min_pattern_rocks: 200 }).part2).to eq(1_514_285_714_288)
    end
  end
end
