require 'rspec'
require 'card'

describe Card do
  let(:card) {Card.new(:hearts, :ace)}
  describe "#Card.suits" do
    it "checks number of suits for Card" do
      expect(Card.suits.length).to eq(4)
    end
  end

  describe "#Card.values" do
    it "checks number of values for Card" do
      expect(Card.values.length).to eq(13)
    end
  end

  describe "#initialize" do
    it "initializes correctly with suit" do
      expect(card.suit).to eq(:hearts)
    end

    it "initializes correctly with value" do
      expect(card.value).to eq(:ace)
    end
  end

  describe "#to_s" do
    it "changes value and suit to alphabet and unicode, respectively" do
      expect(card.to_s).to eq("A♥")
    end
  end
end
