# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day15 do
  describe 'part1' do
    it 'solves part1' do
      override_args = { yval: 10 }
      expect(puzzle_test_runner(year: 2022, day: 15, override_args:).part1).to eq(26)
    end
  end

  describe 'part2' do
    it 'solves part2' do
      override_args = { max_val: 20 }
      expect(puzzle_test_runner(year: 2022, day: 15, override_args:).part2).to eq(56_000_011)
    end
  end
end
