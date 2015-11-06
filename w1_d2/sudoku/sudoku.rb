class Tile
  attr_accessor :value
  def initialize(value)
    @value = value
    @given = false
  end

  def to_s
    if @given == true
      @value
    elsif @given == false
      0
    end
  end
end

class Board
  def initialize(grid= Array.new(9) { Array.new(9)})
    @grid = grid
  end

  def populate
    8.times do |i|
      8.times do |j|
        @grid[i][j] = Tile.new(0)
      end
    end
  end

  def load_file
    puzzle = File.readlines('sudoku1.txt')
    puzzle.each_with_index do |el, i|
      el.chomp
      @grid[i] = el
    end
  end

  def update_pos(pos)

  end

  def render
    @grid.each do |i|
      i.each do |j|
        puts j.value if !j.nil?
      end
    end
  end

  def solved?

  end

  def row_solved?
  end

  def column_solved?
  end

  def square_solved?
  end

end

class Game
  def initialize(board= Board.new)
    @board = board
  end

  def play
    until @board.solved?
      @board.render
      values = get_input
      update_pos
    end
  end

end



