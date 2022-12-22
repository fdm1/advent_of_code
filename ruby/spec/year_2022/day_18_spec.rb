# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day18 do
  describe 'part1' do
    it 'solves part1 simple' do
      expect(puzzle_test_runner(year: 2022, day: 18, suffix: 'simple').part1).to eq(10)
    end

    it 'solves part1' do
      expect(puzzle_test_runner(year: 2022, day: 18).part1).to eq(64)
    end
  end

  describe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(year: 2022, day: 18).part2).to eq(58)
    end
  end
end
