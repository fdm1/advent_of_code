# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2023::Day07 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(year: 2023, day: 7).part1).to eq(6440)
    end
  end

  describe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(year: 2023, day: 7).part2).to eq(5905)
    end
  end
end
