# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day05 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(2022, 5).part1).to eq('CMZ')
    end
  end

  describe 'part2' do
    it 'solves part2' do
      expect(puzzle_test_runner(2022, 5).part2).to eq('MCD')
    end
  end
end
