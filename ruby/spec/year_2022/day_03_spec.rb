# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day03 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(year: 2022, day: 3).part1).to eq(157)
    end
  end

  describe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(year: 2022, day: 3).part2).to eq(70)
    end
  end
end
