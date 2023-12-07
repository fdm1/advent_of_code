# frozen_string_literal: true

module Year2023
  class Day07 < AdventOfCode::PuzzleBase
    def part1
      determine_value
    end

    def part2
      @hands.map do |hand|
        hand[:type] = use_jokers(hand[:hand])
      end
      sort_hands({ 11 => 1 })
      determine_value
    end

    def determine_value
      value = 0
      @hands.each_with_index do |hand, index|
        value += hand[:bid] * (index + 1)
      end
      value
    end

    HAND_TYPES = %i[
      five_of_a_kind
      four_of_a_kind
      full_house
      three_of_a_kind
      two_pair
      one_pair
      high_card
    ].freeze

    def card_value(card)
      case card
      when 'A'
        14
      when 'K'
        13
      when 'Q'
        12
      when 'J'
        11
      when 'T'
        10
      else
        card.to_i
      end
    end

    def use_jokers(hand)
      jokers = hand.select { |card| card == 11 }
      most_common_card = hand.max_by { |card| hand.count(card) }
      highest_card = hand.max
      new_hand = hand.reject { |card| card == 11 }
      jokers.count.times do
        new_hand << if hand.count(most_common_card) == 1
                      highest_card
                    else
                      most_common_card
                    end
      end
      determine_hand_value(new_hand)
    end

    def determine_hand_value(hand)
      uniq_length = hand.uniq.length
      case uniq_length
      when 5
        :high_card
      when 4
        :one_pair
      when 3
        if hand.any? { |card| hand.count(card) == 3 }
          :three_of_a_kind
        else
          :two_pair
        end
      when 2
        if hand.any? { |card| hand.count(card) == 4 }
          :four_of_a_kind
        else
          :full_house
        end
      when 1
        :five_of_a_kind
      end
    end

    def sort_hands(value_overrides = {})
      sorted_hands = []
      HAND_TYPES.each do |hand_type|
        type_hands = @hands.select { |hand| hand[:type] == hand_type }
        sorted_hands << type_hands.sort_by do |hand|
          hand[:hand].map do |h|
            value_overrides[h] || h
          end.map(&:to_s).map { |n| n.rjust(2, '0') }.join # rubocop:disable Style/MultilineBlockChain
        end.reverse
      end
      @hands = sorted_hands.flatten.reverse
    end

    # setup gets called as part of initialize
    def setup
      @hands = []
      @input.split("\n").collect do |player|
        hand, bid = player.split
        hand = hand.chars.map { |card| card_value(card) }
        bid = bid.to_i
        @hands << { hand:, bid:, type: determine_hand_value(hand) }
      end
      sort_hands
    end
  end
end
