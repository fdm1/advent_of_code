# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2021::Day01 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(2021, 1).part1).to eq(7)
    end
  end
end
