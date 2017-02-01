require_relative "card"

class Deck
  attr_reader :stack
  
  def initialize
    @stack = Array.new()
    populate
    shuffle!
  end

  def populate
    suits = [:spade, :heart, :diamond, :club]
    suits.each do |suit|
      (2..14).each do |value|
        stack << Card.new(value,suit)
      end
    end
  end

  def shuffle!
    @stack.shuffle!
  end

  def deal
    @stack.pop
  end

end
