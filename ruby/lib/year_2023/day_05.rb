# frozen_string_literal: true

module Year2023
  class Day05 < AdventOfCode::PuzzleBase
    def part1
      @seeds.collect { |seed| find_seed_location(seed) }.min
    end

    def part2
      range_seeds = []
      @seeds.each_with_index do |seed, index|
        range_seeds << Range.new(seed, seed + @seeds[index + 1] - 1) if index.even?
      end
      location = 0
      loop do
        seed = find_location_seed(location)
        return location if range_seeds.any? { |r| r.include?(seed) }

        location += 1
      end
    end

    def parse_mapping(mapping_lines)
      mapping_name = mapping_lines.first.split.first.gsub('-to-', '_to_').to_sym
      @mappings[mapping_name] = []
      mapping_lines[1..].map do |mapping_line|
        destination, source, range = mapping_line.split.map(&:to_i)
        @mappings[mapping_name] << {
          source_range: Range.new(source, source + range - 1),
          destination_range: Range.new(destination, destination + range - 1)
        }
      end
    end

    def find_next_value(seed, mapping_key)
      applicable_range = @mappings[mapping_key].find { |mapping| mapping[:source_range].include?(seed) }
      return seed unless applicable_range

      applicable_range[:destination_range].first + (seed - applicable_range[:source_range].first)
    end

    def find_seed_location(seed)
      soil = find_next_value(seed, :seed_to_soil)
      fertilizer = find_next_value(soil, :soil_to_fertilizer)
      water = find_next_value(fertilizer, :fertilizer_to_water)
      light = find_next_value(water, :water_to_light)
      temperature = find_next_value(light, :light_to_temperature)
      humidity = find_next_value(temperature, :temperature_to_humidity)
      find_next_value(humidity, :humidity_to_location)
    end

    def find_previous_value(value, mapping_key)
      applicable_range = @mappings[mapping_key].find { |mapping| mapping[:destination_range].include?(value) }
      return value unless applicable_range

      applicable_range[:source_range].first + (value - applicable_range[:destination_range].first)
    end

    def find_location_seed(location)
      humidity = find_previous_value(location, :humidity_to_location)
      temperature = find_previous_value(humidity, :temperature_to_humidity)
      light = find_previous_value(temperature, :light_to_temperature)
      water = find_previous_value(light, :water_to_light)
      fertilizer = find_previous_value(water, :fertilizer_to_water)
      soil = find_previous_value(fertilizer, :soil_to_fertilizer)
      find_previous_value(soil, :seed_to_soil)
    end

    def setup
      @mappings = {}
      mapping_sections = @input.split("\n\n")
      mapping_sections.each do |mapping_lines|
        if mapping_lines.include?('seeds: ')
          @seeds = mapping_lines.split(': ').last.split.map(&:to_i)
        else
          parse_mapping(mapping_lines.split("\n"))
        end
      end
    end
  end
end
