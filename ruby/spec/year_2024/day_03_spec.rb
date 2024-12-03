# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2024::Day03 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(year: 2024, day: 3).part1).to eq(161)
    end
  end

  describe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(year: 2024, day: 3, suffix: 'part2').part2).to eq(48)
    end
  end
end
