require "rspec"
require "deck"

describe Deck do
  let(:deck) { Deck.new }

  describe "#initialize" do
    it "should initialize with 52 cards" do
      expect(deck.cards.length).to eq(52)
    end

    it "should contain 13 of each suit" do
      count_hash = Hash.new(0)
      deck.cards.each { |card| count_hash[card.suit] += 1 }

      expect(count_hash.values.inject(:+)).to eq(52)
    end
  end

  describe "#take" do
    it "should take the correct num of cards from the deck" do
      taken = deck.cards[0..1]
      expect(deck.take(2)).to eq(taken)
      expect(deck.cards.length).to eq(50)
    end
  end

  describe "#return" do
    it "should return an array of cards to the deck" do
      returned = deck.return([Card.new(:hearts, :ace), Card.new(:hearts, :deuce)])
      expect(deck.cards.length).to eq(54)
    end
  end
end
