require_relative 'board'
require 'yaml'

class Game
  def initialize
    @board = Board.new
  end

  def play
    lose = true

    until !lose

      # prompt
      puts "Select a square with a row and column (ex. 1,1)"
      puts "Prepend with F, to flag. (ex. F,1,1)"
      puts "Type save to save game and quit"
      user_input = gets.chomp

      pos = parse(user_input)
      if pos.length == 2
        lose = @board.make_move(pos) #make_move will return false when we lose
      else
        lose = @board.make_move(pos[0],pos[1..2]) #make_move will return false when we lose
      end
      @board.render
      puts "You lose." if !lose
      Kernel.abort("You Win!") if win?
    end
  end

  def parse(string)
    save if string == "save"
    input = string.split(",")
    if input.length == 3
      flag = input[0]
      coords = input[1..2].map {|x| Integer(x)}
      [flag,coords].flatten
    else
      string.split(",").map {|x| Integer(x)}
    end
  end

  def save
    File.open('game_state','w') {|f| f.write(self.to_yaml)}
    Kernel.abort("file saved")
  end


  def win? # we win when all the non-bomb squares are revealed
    flat_board = @board.grid.flatten
    revealed_count = 0

    flat_board.each do |tile|
      revealed_count += 1 if tile.revealed
    end

    (revealed_count + @board.bomb_count) == flat_board.length
  end
end




if __FILE__ == $PROGRAM_NAME
  if ARGV[0].nil?
    game = Game.new
    game.play
  else
    filename = ARGV.shift
    game = YAML::load_file(filename)

    game.play
  end
end
