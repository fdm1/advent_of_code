# frozen_string_literal: true

require 'spec_helper'

RSpec.describe YearYEAR::DayLEFT_PADDED_DAY do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(year: YEAR, day: DAY).part1).to eq(1)
    end
  end

  xdescribe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(year: YEAR, day: DAY).part2).to eq(2)
    end
  end
end
