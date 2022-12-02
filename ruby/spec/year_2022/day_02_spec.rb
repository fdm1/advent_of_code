# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day02 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(2022, 2).part1).to eq(15)
    end
  end

  describe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(2022, 2).part2).to eq(12)
    end
  end
end
