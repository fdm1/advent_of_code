# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day19 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(year: 2022, day: 19).part1).to eq(33)
    end
  end

  xdescribe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(year: 2022, day: 19).part2).to eq(2)
    end
  end
end
