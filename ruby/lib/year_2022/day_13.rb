# frozen_string_literal: true

module Year2022
  class Day13 < AdventOfCode::PuzzleBase
    def part1
      res = @pairs.each_with_index.collect do |p, index|
        pair = Year2022Day13Pair.new(p[0], p[1])
        pair.is_valid? ? index + 1 : nil
      end
      res.compact.sum
    end

    def part2
      @packets_sorted = false
      @sorted_packets = []

      until @packets_sorted
        @all_packets.each do |packet|
          is_smallest = @all_packets.filter { |p| p != packet }.collect do |other_packet|
            Year2022Day13Pair.new(packet, other_packet).is_valid?
          end.all?

          next unless is_smallest

          @sorted_packets << packet
          @all_packets.delete(packet)
          @packets_sorted = @all_packets.empty?
        end
      end
      @decoder_packets.collect { |p| @sorted_packets.index(p) + 1 }.inject(&:*)
    end

    private

    def setup
      @decoder_packets = [
        [[2]],
        [[6]]
      ]
      @all_packets = @decoder_packets.dup
      pairs = @input.split("\n\n")
      @pairs = pairs.collect do |p|
        parsed_pairs = p.split("\n").map { |r| JSON.parse(r) }
        @all_packets += parsed_pairs
        parsed_pairs
      end
    end
  end
end

class Year2022Day13Pair
  def initialize(left, right)
    @left = left
    @right = right

    @processed = false
    @valid = true
  end

  def is_valid?
    compare(@left, @right)
    @valid
  end

  private

  def compare_ints(left, right)
    return if @processed

    @valid = false if left > right
    @processed = true if left != right
  end

  def compare(left, right)
    return if @processed

    if left.is_a?(Integer) && right.is_a?(Integer)
      compare_ints(left, right)
    elsif left.is_a?(Array) && right.is_a?(Array)
      left.each_with_index do |left_value, index|
        compare(left_value, right[index])
      end
      if !@processed && left.size != right.size
        @valid = left.size < right.size
        @processed = true
      end
    elsif left.is_a?(Array) && right.is_a?(Integer)
      compare(left, [right])
    elsif left.is_a?(Integer) && right.is_a?(Array)
      compare([left], right)
    end
  end
end
