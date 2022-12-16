# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day01 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(year: 2022, day: 1).part1).to eq(24_000)
    end
  end

  describe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(year: 2022, day: 1).part2).to eq(45_000)
    end
  end
end
