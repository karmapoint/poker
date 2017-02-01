require 'manifest'

describe Poker

  describe Card
    subject(:card) {Card.new(2, :spade)}

    describe "#initialize" do

      it "sets a value" do
        expect(card.value).to eq(2)
      end

      it "sets a suit" do
        expect(card.suit).to eq(:spade)
      end
    end

    describe "#to_s" do
      let(:king) {Card.new(13, :spade)}

      it "displays face cards as letters" do
        expect(king.to_s).to eq("K\u2660")
      end

      it "prints number and unicode" do
        expect(card.to_s).to eq("2\u2660")
      end
    end

    describe "#==" do
      let("2ofspades") {Card.new(2, :spade)}
      let("8ofhearts") {Card.new(8, :heart)}

      expect(2ofspades).to_not eq(8ofhearts)
    end
  end

  describe Deck
    subject(:deck) {Deck.new}

    describe "#initialize" do

      it "is an array of length 52" do
        expect(deck.stack.length).to eq(52)
      end

      it "has 52 cards" do
        expect(deck.stack.all? { |card| card.is_a?(Card)}).to be true
      end

      it "has 13 cards per suit" do
        spades = deck.stack.select { |card| card.suit == :spade}
        hearts = deck.stack.select { |card| card.suit == :heart}
        diamonds = deck.stack.select { |card| card.suit == :diamond}
        clubs = deck.stack.select { |card| card.suit == :club}

        expect(spades.length).to eq(13)
        expect(hearts.length).to eq(13)
        expect(diamonds.length).to eq(13)
        expect(clubs.length).to eq(13)
      end
    end

    describe "#shuffle!" do

      it "shuffle the deck" do
        original_deck = deck.dup
        deck.shuffle!

        expect(original_deck.stack[0]).to_not eq(deck.stack[0])
        expect(original_deck.stack[15]).to_not eq(deck.stack[15])
        expect(original_deck.stack[40]).to_not eq(deck.stack[40)
      end
    end

    describe "#deal" do

      it "returns a card from the top of the deck" do
        top = deck.stack.last
        expect(deck.deal).to eq(top)
      end

      it "decreases the number of cards left" do
        deck.deal
        expect(deck.stack.length).to eq(51)
      end
    end
  end
end