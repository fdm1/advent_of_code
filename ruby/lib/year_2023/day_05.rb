# frozen_string_literal: true

module Year2023
  class Day05 < AdventOfCode::PuzzleBase
    def part1
      setup
      @seeds.collect { |seed| find_seed_location(seed) }.min
    end

    def part2
    end

    def parse_mapping(mapping_lines)
      mapping_name = mapping_lines.first.split(" ").first.gsub("-to-", "_to_").to_sym
      @mappings[mapping_name] = {}
      mapping_lines[1..-1].map do |mapping_line|
        destination, source, range = mapping_line.split(" ").map(&:to_i)
        range.times do |i|
          @mappings[mapping_name][source + i] = destination + i
        end
      end
      @mappings[mapping_name]
    end

    def find_next_value(seed, mapping)
      mapping[seed] || seed
    end

    def find_seed_location(seed)
      soil = find_next_value(seed, @mappings[:seed_to_soil])
      fertilizer = find_next_value(soil, @mappings[:soil_to_fertilizer])
      water = find_next_value(fertilizer, @mappings[:fertilizer_to_water])
      light = find_next_value(water, @mappings[:water_to_light])
      temperature = find_next_value(light, @mappings[:light_to_temperature])
      humidity = find_next_value(temperature, @mappings[:temperature_to_humidity])
      find_next_value(humidity, @mappings[:humidity_to_location])
    end

    def setup
      @mappings = {}
      mapping_sections = @input.split("\n\n")
      mapping_sections.each do |mapping_lines|
        if mapping_lines.include?("seeds: ")
          @seeds = mapping_lines.split(": ").last.split(" ").map(&:to_i)
        else
          parse_mapping(mapping_lines.split("\n"))
        end
      end
    end
  end
end
