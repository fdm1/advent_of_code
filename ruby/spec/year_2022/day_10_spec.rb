# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day10 do
  describe 'part1' do
    it 'solves part1' do
      expect(puzzle_test_runner(2022, 10).part1).to eq(13_140)
    end
  end

  describe 'part2' do
    let(:expected_output) do
      <<~RES

        ##  ##  ##  ##  ##  ##  ##  ##  ##  ##
        ###   ###   ###   ###   ###   ###   ###
        ####    ####    ####    ####    ####
        #####     #####     #####     #####
        ######      ######      ######      ####
        #######       #######       #######
      RES
    end

    it 'solves part2' do
      expect(puzzle_test_runner(2022, 10).part2).to eq(expected_output.chomp)
    end
  end
end
