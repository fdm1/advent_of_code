# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day12 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(year: 2022, day: 12).part1).to eq(31)
    end
  end

  describe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(year: 2022, day: 12).part2).to eq(29)
    end
  end
end
