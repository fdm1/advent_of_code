# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2023::Day11 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(year: 2023, day: 11).part1).to eq(374)
    end
  end

  xdescribe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(year: 2023, day: 11).part2).to eq(2)
    end
  end
end
