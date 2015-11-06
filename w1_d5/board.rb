require_relative 'tile'

class Board
  attr_reader :grid, :bomb_count

  def initialize(grid = Array.new(9) {Array.new(9)}, bomb_count = 10)
    @grid = grid
    @bomb_count = bomb_count
    populate_grid
    seed_bombs
  end

  def populate_grid
    @grid.each_with_index do |row, i|
      row.each_index do |col|
        row[col] = Tile.new(self, [i,col])
      end
    end
  end

  def seed_bombs
    bombs_placed = 0

    until bombs_placed == @bomb_count
      row = rand(@grid.length-1)
      col = rand(@grid[0].length-1)
      if !@grid[row][col].bombed
        @grid[row][col].bombed = true
        bombs_placed += 1
      end
    end
  end

  def render
    @grid.each do |row|
      row.each_index do |col|
        print "#{row[col].state} "
      end
      puts ""
    end
  end

  def make_move(flag = nil, pos)
    row = pos[0] - 1
    col = pos[1] - 1

    @grid[row][col].reveal(flag)
  end
end

# board = Board.new
# board.render
# board.make_move([3,3])
# system 'clear'
# board.render
