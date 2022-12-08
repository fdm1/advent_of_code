# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day08 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(2022, 8).part1).to eq(21)
    end
  end

  describe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(2022, 8).part2).to eq(8)
    end
  end
end
