require_relative 'deck'

class Hand

  POINTS = {
    :high_card          => 1,
    :one_pair           => 2,
    :two_pair           => 3,
    :three_of_a_kind    => 4,
    :straight           => 5,
    :flush              => 6,
    :full_house         => 7,
    :four_of_a_kind     => 8,
    :straight_flush     => 9,
  }

  attr_accessor :cards

  def initialize(deck)
    @cards = []
    @cards += deck.take(5)
  end

  def straight_flush
    unless flush.nil? && straight.nil?
      cards
    end
  end


  def flush
    if cards.all? { |card| cards[0].suit == card.suit }
      cards
    end
  end

  def high_card
    cards.max_by(&:poker_value)
  end

  def full_house
    count_hash = Hash.new(0)
    cards.each do |card|
      count_hash[card.value] += 1
    end
    return nil if count_hash.values.any? { |val| val == 1 }
    cards
  end


  def one_pair
    sorted_cards = cards.sort_by(&:poker_value)
    result = []
    sorted_cards.each_with_index do |card, i|
      break if sorted_cards[i+1].nil?
      if sorted_cards[i+1].value == card.value
        result << card
        result << sorted_cards[i+1]
      end
    end
    if result.length == 2
      return result
    else
      nil
    end
  end

  def two_pair
    sorted_cards = cards.sort_by(&:poker_value)
    result = []
    sorted_cards.each_with_index do |card, i|
      break if sorted_cards[i+1].nil?
      if sorted_cards[i+1].value == card.value
        result << card
        result << sorted_cards[i+1]
      end
    end
    if result.length == 4 && result.any? { |card| card.value != result[0].value }
      return result
    else
      nil
    end
  end

  def three_of_a_kind
    sorted_cards = cards.sort_by(&:poker_value)
    result = []
    sorted_cards.each_with_index do |card, i|
      break if sorted_cards[i+1].nil?
      if sorted_cards[i+1].value == card.value
        result << card unless result.include?(card)
        result << sorted_cards[i+1]
      end
    end
    if result.length == 3
      return result
    else
      nil
    end
  end

  def four_of_a_kind
    sorted_cards = cards.sort_by(&:poker_value)
    result = []
    sorted_cards.each_with_index do |card, i|
      break if sorted_cards[i+1].nil?
      if sorted_cards[i+1].value == card.value
        result << card unless result.include?(card)
        result << sorted_cards[i+1]
      end
    end
    if result.length == 4
      return result
    else
      nil
    end
  end

  def straight
    sorted_cards = cards.sort_by(&:poker_value)
    sorted_cards.each_with_index do |card, i|
      break if sorted_cards[i+1].nil?
      return nil if (sorted_cards[i+1].poker_value - card.poker_value) != 1
    end
    cards
  end


  def points
    points = 0
    if straight_flush
      points += POINTS[:straight_flush]
    elsif four_of_a_kind
      points += POINTS[:four_of_a_kind]
    elsif full_house
      points += POINTS[:full_house]
    elsif flush
      points += POINTS[:flush]
    elsif straight
      points += POINTS[:straight]
    elsif three_of_a_kind
      points += POINTS[:three_of_a_kind]
    elsif two_pair
      points += POINTS[:two_pair]
    elsif one_pair
      points += POINTS[:one_pair]
    elsif high_card
      points += POINTS[:high_card]
    end
    points
  end

  def beats?(other_hand)
    if other_hand.points > points
      return false
    elsif points > other_hand.points
      return true
    else
      win_type = POINTS.select { |_,v| v == points }.keys[0].to_s
      op_added = other_hand.send(win_type).sort_by(&:poker_value).last.poker_value
      added = send(win_type).sort_by(&:poker_value).last.poker_value
      return false if op_added > added
      return true if added > op_added
    end
  end




end
