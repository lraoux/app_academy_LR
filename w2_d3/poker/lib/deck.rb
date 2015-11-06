require_relative "card"

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    populate_deck
  end

  def populate_deck
    Card.suits.each do |suit|
      Card.values.each do |value|
        @cards << Card.new(suit,value)
      end
    end
    @cards.shuffle!
  end

  def take(num)
    @cards.shift(num)
  end


  def return(cards)
    @cards += cards
  end

end
