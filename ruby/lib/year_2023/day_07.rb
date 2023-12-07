# frozen_string_literal: true

module Year2023
  class Day07 < AdventOfCode::PuzzleBase
    def part1
      value = 0
      @hands.each_with_index do |hand, index|
        value += hand[:bid] * (index + 1)
      end
      value
    end

    def part2; end

    HAND_TYPES = {
      five_of_a_kind: 6,
      four_of_a_kind: 5,
      full_house: 4,
      three_of_a_kind: 3,
      two_pair: 2,
      one_pair: 1,
      high_card: 0
    }.freeze

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

    def determine_hand_value(hand)
      uniq_length = hand.uniq.length
      case uniq_length
      when 5
        HAND_TYPES[:high_card]
      when 4
        HAND_TYPES[:one_pair]
      when 3
        if hand.count(hand[0]) == 3 || hand.count(hand[1]) == 3 || hand.count(hand[2]) == 3
          HAND_TYPES[:three_of_a_kind]
        else
          HAND_TYPES[:two_pair]
        end
      when 2
        if hand.count(hand[0]) == 1 || hand.count(hand[0]) == 4
          HAND_TYPES[:four_of_a_kind]
        else
          HAND_TYPES[:full_house]
        end
      when 1
        HAND_TYPES[:five_of_a_kind]
      end
    end

    def sort_hands
      sorted_hands = []
      HAND_TYPES.each_value do |hand_type|
        type_hands = @hands.select { |hand| hand[:type] == hand_type }
        sorted_hands << type_hands.sort_by { |hand| hand[:hand].map(&:to_s).join }.reverse
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
