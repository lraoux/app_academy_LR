require_relative 'hand'

class Player

  attr_reader :hand, :deck, :name
  attr_accessor :bank

  def initialize(deck,name)
    @hand = Hand.new(deck)
    @deck = deck
    @bank = 100
    @name = name
  end

  def display_hand
    hand.cards.each do |card|
      print card.to_s + " "
    end
    puts
  end

  def discard(*card_indices)
    raise "You can't discard more than 3 cards" if card_indices.length > 3
    card_indices.each do |index|
      deck.return([hand.cards[index]])
      hand.cards.delete_at(index)
    end
    hand.cards += deck.take(card_indices.length)
  end

  def fold
    hand.cards = []
  end

  def prompt
    puts
    puts "What would you like to do?".colorize(:yellow)
    puts "Bet, see, raise, fold, or discard up to 3 cards? (Ex: discard 0,3,4)".colorize(:yellow)
    puts "Bank: #{@bank}".colorize(:green)
    puts
    display_hand
  end

  def play_move
    prompt
    input = gets.chomp.downcase
    if input.include?("discard")
      nums = input.split.drop(1).join.split(",")
      nums.each do |num|
        discard(num.to_i)
      end
    elsif input == "fold"
      fold
      return "fold"
    elsif input == "see"
      return "see"
    else
      amount = input.split[1].to_i
      @bank -= amount
      return amount
    end
  end


end
