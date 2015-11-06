require 'byebug'
class Card
    attr_accessor :face_value, :status

    def initialize(face_value)
      @face_value = face_value
      @status = :face_down
    end

    def hide
      @nil
    end

    def reveal
      @face_value
    end

    def change_status
      if @status == :face_down
        @status = :face_up
      elsif @status == :face_up
        @status = :face_down
      end
    end

end


class Board
    attr_reader :grid

    def initialize
      @grid = Array.new(4) {Array.new(5)}
    end

    def populate
      (1..10).each do |val|
        2.times do
          a = Card.new(val)
          row = rand(0..3)
          col = rand(0..4)
          while !@grid[row][col].nil?
            row = rand(0..3)
            col = rand(0..4)
          end
          @grid[row][col] = a
        end
      end
    end

    def render
      rendered_grid = Array.new(4) {Array.new(5)}
      4.times do |row_idx|
        5.times do |col_idx|
          if grid[row_idx][col_idx].status == :face_down
            rendered_grid[row_idx][col_idx] = "X"
          else
            rendered_grid[row_idx][col_idx] = grid[row_idx][col_idx].face_value
          end
        end
      end
      rendered_grid.each do |el|
        p el.map {|el| " " + "#{el}" + " "}.join("")
      end
      puts ""
    end

    def won?
      grid.flatten.each do |card|
        if card.status == :face_down
          return false
        end
      end
      true
    end

    def turnover(guess)
      if grid[guess[0]][guess[1]].status == :face_down
        grid[guess[0]][guess[1]].change_status
        grid[guess[0]][guess[1]].reveal
      end

    end

end

class Game
  attr_reader :game_board, :player
  attr_accessor :prev_guess
  def initialize(player)
    @game_board = Board.new
    @prev_guess = []
    @player=player
   end

  def play
    until over?
      system("clear")
      game_board.render
      guess_pos = player.prompt
      make_guess(guess_pos)
    end
    game_board.render
    Kernel.abort("GOOD JOB!")
  end

  def make_guess(input_array)
    game_board.turnover(input_array)
    if prev_guess.empty?
      @prev_guess = input_array
      player.previous_guess = prev_guess
      player.receive_revealed_card(prev_guess, game_board.grid[prev_guess[0]][prev_guess[1]].face_value)
      #pass this to the computer or the 2nd guess will never account for it...
    elsif !prev_guess.empty?
      prev_guess_value = game_board.grid[prev_guess[0]][prev_guess[1]].face_value
      input_guess_value = game_board.grid[input_array[0]][input_array[1]].face_value
      if prev_guess_value != input_guess_value
        player.receive_revealed_card(prev_guess, prev_guess_value)
        player.receive_revealed_card(input_array, input_guess_value)
        game_board.render
        game_board.grid[prev_guess[0]][prev_guess[1]].change_status
        game_board.grid[input_array[0]][input_array[1]].change_status
        p "Incorrect Match"
        sleep(2)
      elsif prev_guess_value == input_guess_value
        player.receive_revealed_card(prev_guess, prev_guess_value)
        player.receive_revealed_card(input_array, input_guess_value)
        player.receive_match(prev_guess, input_array)
        game_board.render
        p "Correct Match"
      end
       @prev_guess = []
       player.previous_guess = nil
    end

  end


  def over?
    game_board.won?
  end

end

class HumanPlayer
  attr_accessor :previous_guess

  def prompt
    puts "Provide a row number: "
    input_row = gets.chomp.to_i
    puts "Provide a column number: "
    input_col = gets.chomp.to_i
    return [input_row-1, input_col-1]
  end

  def get_prior_input(*args)
  end

  def get_input(*args)
  end

  def receive_revealed_card(pos, val)
  end

  def receive_match(pos1, pos2)

  end



end

class ComputerPlayer

    attr_accessor :known_cards, :matched_cards, :previous_guess

    def initialize
      @known_cards = {}
      @matched_cards = []
      @previous_guess = nil
    end

    def prompt
      if !previous_guess.nil?
        pos = []
        @known_cards.each do |pos1,val|
          if pos1 != previous_guess && val == @known_cards[previous_guess] && !@matched_cards.include?(pos1)
            pos << pos1
          end
        end

        if pos.empty?
           rand_guess
        else
          pos.first
        end
      elsif previous_guess.nil?
        pos = []
        @known_cards.each do |pos1, val1|
          @known_cards.each do |pos2, val2|
            if val1 == val2 && pos1 != pos2 && !@matched_cards.include?(pos1)
              pos << pos1
            end
          end
        end

        if pos.empty?
          rand_guess
        else
          pos.first
        end
      end

    end
    #problem at 1 a.m.: known position has a 6, previous guess is nil, first guess of
    #new round you uncover a 6. maybe causing the looping.

    def rand_guess
      input_row = rand(1..4)
      input_col = rand(1..5)
      while @known_cards.keys.include?([input_row-1, input_col-1])
        input_row = rand(1..4)
        input_col = rand(1..5)
      end
      [input_row-1, input_col-1]
    end

    def receive_revealed_card(pos, val)
      known_cards[pos] = val
    end

    def receive_match(pos1, pos2)
      @matched_cards << pos1
      @matched_cards << pos2
    end


end

comp = ComputerPlayer.new
game = Game.new(comp)
game.game_board.populate
game.play