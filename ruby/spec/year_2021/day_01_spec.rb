# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2021::Day01 do
  describe 'part1' do
    it 'solves part1' do
      input_file = 'spec/support/test_input/2021/01.txt'
      expect(described_class.new.part1(input_file)).to eq(7)
    end
  end
end
