# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2015::Day07 do
  describe 'part1' do
    let(:expected_output) do
      {
        d: 72,
        e: 507,
        f: 492,
        g: 114,
        h: 65_412,
        i: 65_079,
        x: 123,
        y: 456
      }.transform_keys(&:to_s)
    end

    it 'solves part1' do
      expect(puzzle_test_runner(2015, 7).part1).to eq(expected_output)
    end
  end
end
