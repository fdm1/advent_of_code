# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day09 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(year: 2022, day: 9).part1).to eq(13)
    end
  end

  describe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(year: 2022, day: 9).part2).to eq(1)
    end

    it 'solves part2 expanded' do
      expect(puzzle_test_runner(year: 2022, day: 9, suffix: 'expanded').part2).to eq(36)
    end
  end
end
