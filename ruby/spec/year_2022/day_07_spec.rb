# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day07 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(2022, 7).part1).to eq(95_437)
    end
  end

  describe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(2022, 7).part2).to eq(24_933_642)
    end
  end
end
