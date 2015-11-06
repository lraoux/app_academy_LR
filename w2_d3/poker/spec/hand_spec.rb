require 'rspec'
require 'hand'

describe Hand do
  let(:deck) { Deck.new }
  let(:hand) { Hand.new(deck) }

  describe "#initialize" do
    it "starts the hand with 5 cards" do
      expect(hand.cards.length).to eq(5)
    end
  end

  describe "hands" do
    context "#flush" do
      let(:flush_hand) {[
                        Card.new(:diamonds, :ace),
                        Card.new(:diamonds, :deuce),
                        Card.new(:diamonds, :three),
                        Card.new(:diamonds, :four),
                        Card.new(:diamonds, :five)
                       ]}
      it "will return the flush hand for a flush" do
        hand.cards = flush_hand
        expect(hand.flush).to eq(flush_hand)
      end
    end

    context "#high_card" do
      let(:high_hand) {[
                        Card.new(:diamonds, :ace),
                        Card.new(:diamonds, :deuce)
                        ]}
      it "returns highest card in hand" do
        hand.cards = high_hand
        expect(hand.high_card).to eq(hand.cards[0])
      end
    end

    context "#one_pair" do
      let(:one_pair_hand) {[
                        Card.new(:hearts, :ace),
                        Card.new(:diamonds, :ace),
                        Card.new(:diamonds, :three),
                        Card.new(:clubs, :four),
                        Card.new(:diamonds, :five)
                       ]}
      it "returns one pair" do
        hand.cards = one_pair_hand
        expect(hand.one_pair).to eq([hand.cards[1],hand.cards[0]])
      end
    end

    context "#two_pair" do
      let(:two_pair_hand) {[
                        Card.new(:hearts, :ace),
                        Card.new(:diamonds, :ace),
                        Card.new(:diamonds, :three),
                        Card.new(:clubs, :three),
                        Card.new(:diamonds, :five)
                       ]}
      it "returns two pairs" do
        hand.cards = two_pair_hand
        expect(hand.two_pair).to eq([Card.new(:diamonds, :three),
                                     Card.new(:clubs, :three),
                                     Card.new(:diamonds, :ace),
                                     Card.new(:hearts, :ace),
                                      ])
      end
    end

    context "#three_of_a_kind" do
      let(:three_of_a_kind_hand) {[
                        Card.new(:hearts, :ace),
                        Card.new(:diamonds, :ace),
                        Card.new(:clubs, :ace),
                        Card.new(:clubs, :three),
                        Card.new(:diamonds, :five)
                       ]}
      it "returns three of a kind" do
        hand.cards = three_of_a_kind_hand
        expect(hand.three_of_a_kind).to eq([
                                     Card.new(:clubs, :ace),
                                     Card.new(:diamonds, :ace),
                                     Card.new(:hearts, :ace)
                                      ])
      end
    end

    context "#straight" do
      let(:straight_hand) {[
                        Card.new(:hearts, :six),
                        Card.new(:diamonds, :three),
                        Card.new(:clubs, :deuce),
                        Card.new(:clubs, :four),
                        Card.new(:diamonds, :five)
                       ]}
      it "returns the straight" do
        hand.cards = straight_hand
        expect(hand.straight).to eq(hand.cards)
      end
    end

    context "#four_of_a_kind" do
      let(:four_of_a_kind_hand) {[
                        Card.new(:hearts, :six),
                        Card.new(:diamonds, :six),
                        Card.new(:clubs, :deuce),
                        Card.new(:clubs, :six),
                        Card.new(:spades, :six)
                       ]}
      it "returns the four_of_a_kind" do
        hand.cards = four_of_a_kind_hand
        expect(hand.four_of_a_kind).to eq([
                          Card.new(:hearts, :six),
                          Card.new(:diamonds, :six),
                          Card.new(:clubs, :six),
                          Card.new(:spades, :six)
                        ])
      end
    end

    context "#full_house" do
      let(:full_house_hand) {[
                        Card.new(:hearts, :six),
                        Card.new(:diamonds, :six),
                        Card.new(:clubs, :deuce),
                        Card.new(:hearts, :deuce),
                        Card.new(:spades, :deuce)
                       ]}
      it "returns the full_house" do
        hand.cards = full_house_hand
        expect(hand.full_house).to eq(hand.cards)
      end
    end

    context "#straight_flush" do
      let(:straight_flush_hand) {[
                        Card.new(:hearts, :ten),
                        Card.new(:hearts, :jack),
                        Card.new(:hearts, :queen),
                        Card.new(:hearts, :king),
                        Card.new(:hearts, :ace)
                       ]}
      it "returns the straight_flush" do
        hand.cards = straight_flush_hand
        expect(hand.straight_flush).to eq(hand.cards)
      end
    end
  end
  describe "#points" do
    context "points for straight_flush" do
      let(:straight_flush_hand) {[
                        Card.new(:hearts, :ten),
                        Card.new(:hearts, :ten),
                        Card.new(:hearts, :queen),
                        Card.new(:hearts, :king),
                        Card.new(:hearts, :ace)
                       ]}
      it "returns the point for straight_flush" do
        hand.cards = straight_flush_hand
        expect(hand.points).to eq(9)
      end
    end
  end

  describe "#beats?" do
    context "beats opponent" do
      let(:winning_hand) {[
                        Card.new(:spades, :jack),
                        Card.new(:hearts, :jack),
                        Card.new(:hearts, :queen),
                        Card.new(:clubs, :king),
                        Card.new(:hearts, :ace)
                       ]}
     let(:losing_hand) {[
                       Card.new(:spades, :ten),
                       Card.new(:hearts, :ten),
                       Card.new(:hearts, :queen),
                       Card.new(:clubs, :king),
                       Card.new(:hearts, :ace)
                      ]}
      it "winning hand wins" do
        hand.cards = winning_hand
        hand2 = Hand.new(deck)
        hand2.cards = losing_hand
        expect(hand.beats?(hand2)).to eq(true)
      end
    end
  end

end
