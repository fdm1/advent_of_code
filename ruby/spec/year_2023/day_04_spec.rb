# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2023::Day04 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(year: 2023, day: 4).part1).to eq(13)
    end
  end

  describe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(year: 2023, day: 4).part2).to eq(30)
    end
  end
end
