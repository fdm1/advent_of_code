# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day06 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(2022, 6).part1).to eq(7)
    end
  end

  describe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(2022, 6).part2).to eq(19)
    end
  end
end
