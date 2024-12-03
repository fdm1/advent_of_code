# frozen_string_literal: true

module Year2024
  class Day03 < AdventOfCode::PuzzleBase
    START_BAD_REGEX = /don't\(\)/
    END_BAD_REGEX = /do\(\)/
    MULT_REGEX = /mul\(\d+,\d+\)/

    def part1
      generate_answer
    end

    def part2
      generate_answer(clean_input)
    end

    # setup generates called as part of initialize
    def setup
      @input # input is available as the raw input string
    end

    private

    def remove_donts_regex
      # find all strings that start with "don't()" and end with "do()"
      /#{START_BAD_REGEX}.*?#{END_BAD_REGEX}/
    end

    def clean_input
      instructions = @input.dup.split("\n").join
      bad_sections = instructions.scan(remove_donts_regex)
      bad_sections.each do |bs|
        instructions.gsub!(bs, '')
      end
      instructions.split("don't").first
    end

    def extract_mults(input)
      mults = input.scan(MULT_REGEX)
      mults.map { |m| parse_mult(m) }
    end

    def parse_mult(m)
      m.gsub('mul(', '').gsub(')', '').split(',').map(&:to_i)
    end

    def generate_answer(input = @input)
      extract_mults(input).map { |a, b| a * b }.sum
    end
  end
end
