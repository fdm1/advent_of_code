# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2021::Day01 do
  describe 'part1' do
    it 'solves part1' do
      expect(AdventOfCode::Runner.new(2021, 0o1, 'spec/support/test_input').part1).to eq(7)
    end
  end
end
