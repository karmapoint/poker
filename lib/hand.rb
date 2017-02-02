require_relative 'card'
require_relative 'deck'

class Hand

  attr_reader :hand

  VALUATIONS = [
    :high_card,
    :pair,
    :two_pair,
    :three_of_a_kind,
    :straight,
    :flush,
    :full_house,
    :four_of_a_kind,
    :straight_flush
  ]

  def initialize
    @hand = []
  end

  def valuation
    values = []
    hand.each { |card| values << card.value}
    values.sort!

    if straight_flush?
      return [:straight_flush, values.last]

    elsif four_of_a_kind?
      if values.count(values.last) == 4
        return [:four_of_a_kind, values.last, values.first]
      else
        return [:four_of_a_kind, values.first, values.last]
      end

    elsif full_house?
      if values.count(values.last) == 3
        return [:full_house, values.last, values.first]
      else
        return [:full_house, values.first, values.last]
      end

    elsif flush?
      return [:flush, values.last, values.first]

    elsif straight?
      return [:straight, values.last, values.first]

    elsif three_of_a_kind?
      if values.count(values.last) == 3
        return [:three_of_a_kind, values.last, values.first]
      else
        return [:three_of_a_kind, values.first, values.first]
      end

    elsif two_pair?
      paired = values.select { |card| values.count(card) == 2 }.sort!
      return [:two_pair, paired.last, paired.first]

    elsif pair?
      pair = values.select { |card| values.count(card) == 2 }
      leftovers = values.delete(pair[0]).sort
      return [:pair, pair[0], leftovers.last]

    else
      return [:high_card, values.last, values[-2]]
    end
  end

  def straight_flush?
    return true if flush? && straight?
    false
  end

  def four_of_a_kind?
    values = []
    hand.each { |card| values << card.value}
    values.any? { |value| values.count(value) == 4}
  end

  def full_house?
    values = []
    hand.each { |card| values << card.value}
    values.sort!
    return false unless values.uniq.length == 2
    true
  end

  def flush?
    first_suit = hand[0].suit
    @hand.all? {|card| card.suit == first_suit}
  end

  def straight?
    values = []
    hand.each { |card| values << card.value}
    values.sort!
    values.each_with_index do |value, idx|
      return false unless value == values[idx+1]+1
    end
    true
  end

  def three_of_a_kind?
    values = []
    hand.each { |card| values << card.value}
    values.any? { |value| values.count(value) == 3}
  end

  def two_pair?
    values = []
    hand.each { |card| values << card.value}
    values.uniq.length == 3
  end

  def pair?
    values = []
    hand.each { |card| values << card.value}
    values.uniq.length == 4
  end

  def <=>(hand)
    if VALUATIONS[self.valuation[0]].index > VALUATIONS[hand.valuation[0]].index
      return -1
    elsif VALUATIONS[self.valuation[0]].index == VALUATIONS[hand.valuation[0]].index
      return tiebreaker(self, hand)
    elsif VALUATIONS[self.valuation[0]].index < VALUATIONS[hand.valuation[0]].index
      return 1
    end
  end

  def tiebreaker(hand1, hand2)
    return -1 if hand1.valuation[1] < hand2.valuation[1]
    return 1 if hand1.valuation[1] > hand2.valuation[1]

    if hand1.valuation[1] == hand2.valuation[1]
      return -1 if hand1.valuation[2] < hand2.valuation[2]
      return 1 if hand1.valuation[2] > hand2.valuation[2]
      raise "double tie"
    end
  end



  end




end
