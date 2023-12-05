# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2023::Day05 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(year: 2023, day: 5).part1).to eq(35)
    end
  end

  describe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(year: 2023, day: 5).part2).to eq(46)
    end
  end
end
