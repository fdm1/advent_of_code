# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day01 do
  describe 'part1' do
    it 'solves part1' do
      expect(AdventOfCode::Runner.new(2022, 0o1, 'spec/support/test_input').part1).to eq(24_000)
    end
  end

  describe 'part2' do
    it 'solves part2' do
      expect(AdventOfCode::Runner.new(2022, 0o1, 'spec/support/test_input').part2).to eq(45_000)
    end
  end
end
