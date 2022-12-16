# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day11 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(year: 2022, day: 11).part1).to eq(10_605)
    end
  end

  describe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(year: 2022, day: 11).part2).to eq(2_713_310_158)
    end
  end
end
