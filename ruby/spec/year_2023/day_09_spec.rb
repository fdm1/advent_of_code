# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2023::Day09 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(year: 2023, day: 9).part1).to eq(114)
    end
  end

  xdescribe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(year: 2023, day: 9).part2).to eq(2)
    end
  end
end
