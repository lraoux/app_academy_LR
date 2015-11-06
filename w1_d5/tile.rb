class Tile

  attr_accessor :bombed, :revealed, :state

  def initialize(board, coordinates)
    @bombed = false
    @flagged = false
    @revealed = false
    @state = "*"
    @board = board
    @row = coordinates[0]
    @col = coordinates[1]
  end

  def reveal(flag = nil)
    if flag == "F"
      @state = "F"
      return ""
    end

    @revealed = true
    if @bombed
      @state = "B"
      return false
    else
      @state = " "
    end

    neighbors
    unless (neighbor_bomb_count > 0)
      @neighbors.each do |neighbor| #neighbor is tile object
        neighbor.reveal
      end
    end

    if neighbor_bomb_count > 0
      @state = @bomb_count
    end
  end

  def neighbors
    @neighbors = []
    -1.upto(1) do |i|
      -1.upto(1) do |j|
        check_row = @row + i
        check_col = @col + j
        if (check_row >= 0 && check_col >= 0) && (check_row < @board.grid.length && check_col < @board.grid[0].length)
          check_tile = @board.grid[check_row][check_col]
          @neighbors << check_tile unless check_tile.revealed #neighboring tiles get placed into @neighbors
        end
      end
    end
  end

  def neighbor_bomb_count
    @bomb_count = 0
    @neighbors.each {|neigh_tile| @bomb_count += 1 if neigh_tile.bombed}# increases bomb count every time it find a neighboring bomb
    @bomb_count
  end

  def inspect

  end
end
