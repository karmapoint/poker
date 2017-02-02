require_relative 'hand'


class Player


  attr_accessor :my_hand, :name

  def initialize(name = "name")

    @name = name
    @my_hand = Hand.new

  end


end
