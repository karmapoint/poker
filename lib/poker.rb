require_relative 'hand'
require_relative 'deck'
require_relative 'card'
require_relative 'player'

class Poker
  attr_reader :deck
  def initialize
    @players = { :player1 => Player.new("bob"), :player2 => Player.new("joe") }
    @deck = Deck.new
    @whose_turn = :player1
  end

  def deal_hands
    until @players[:player2].my_hand.hand.length == 5
      @players[:player1].my_hand.hand << @deck.deal
      @players[:player2].my_hand.hand << @deck.deal
    end
  end

  def prompt
    puts "#{@players[@whose_turn].name}, which cards do you want to drop?"
    puts "enter up to three positions ex: (0,3,4)"
    drops = gets.chomp.split(",").map { |el| el.to_i }
    drops.each do |i|
      @players[@whose_turn].my_hand.hand.delete_at(i)
    end

    ((drops.length)).times do
      @players[@whose_turn].my_hand.hand << @deck.deal
    end

    display_hand
    sleep(2)

    @whose_turn = (@whose_turn == :player1 ? :player2 : :player1)
  end

  def round
    deal_hands
    display_hand
    prompt
    display_hand
    prompt
    result = (@players[:player1].my_hand.hand <=> @players[:player2].my_hand.hand)

    return "player1 wins!" if result == 1
    return "player2 wins!" if result == -1
    puts result
    "TIE!"
  end

  def display_hand
    @players[@whose_turn].my_hand.hand.each {|card| print "#{card} "}
    puts
    print @players[@whose_turn].my_hand.valuation
    puts
  end

end
