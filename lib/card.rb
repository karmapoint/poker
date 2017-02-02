class Card

  attr_reader :value, :suit

  SUITS = {
    :spade => "\u2660",
    :heart => "\u2661",
    :diamond => "\u2662",
    :club => "\u2663"
  }

  FACES = { 11 => "J", 12 => "Q", 13 => "K", 14 => "A" }


  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    output = ''
    if self.value > 10
      output += FACES[self.value]
    else
      output += self.value.to_s
    end
    output + SUITS[self.suit]
  end

  def ==(card)
    return false unless self.value == card.value
    return false unless self.suit == card.suit
    true
  end

end
