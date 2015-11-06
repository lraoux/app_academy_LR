require_relative "player"

class Game
  attr_reader :deck, :in_round_players, :in_game_players, :current_player, :pot

  def initialize(*player_names)
    @deck = Deck.new
    @in_round_players = []
    player_names.each do |name|
      @in_round_players << Player.new(deck, name.downcase.capitalize)
    end
    @in_game_players = in_round_players.dup
    @current_player = in_round_players.first
    @pot = 0
    @see = 0
  end

  def next_player!
    @in_round_players.rotate!(1)
    @current_player = in_round_players.first
  end

  def play
    until in_game_players == 1
      puts "Round 1!".colorize(:red)
      puts
      play_round
      puts "Round 2!".colorize(:red)
      puts
      play_round
      show_all_cards
      puts "#{round_winner.name} wins this round!"
      award_winner
      puts
      scan_for_bankrupt
      @in_round_players = in_game_players
    end
    puts "#{in_game_players[0]} wins!"
  end

  def play_round
    first_player = in_game_players.first
    while true
      puts "#{current_player.name}, your turn!"
      process_input
      next_player!
      break if current_player == first_player
    end
  end

  def show_all_cards
    in_round_players.each do |player|
      puts "#{player.name}:"
      player.display_hand
    end
  end

  def round_winner
    winner = nil
    in_round_players.each do |player|
      if winner.nil? || player.hand.beats?(winner.hand)
        winner = player
      end
    end
    winner
  end

  def award_winner
    round_winner.bank += pot
    @pot = 0
  end

  def process_input
    amount = current_player.play_move
    if amount.is_a?(Integer)
      @pot += amount
      @see = amount
    elsif amount == "see"
      @pot += @see
      current_player.bank -= @see
    elsif amount == "fold"
      puts "#{current_player.name} folded!"
      @in_round_players -= [current_player]
    end
  end

  def scan_for_bankrupt
    in_game_players.each do |player|
      if player.bank == 0
        @in_game_players -= [player]
        puts "#{player.name} is bankrupt! Goodbye, #{player.name}!"
      end
    end
  end
end

Game.new("david","akansh").play
