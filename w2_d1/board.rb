require_relative 'piece'

class Board
  SIZE = 8
  def initialize
    @grid = Array.new(SIZE) {Array.new(SIZE)}
    populate
  end

  def populate
    2.times do |iter1|
      SIZE.times do |iter2|
        self[iter1, iter2] = Piece.new([iter1,iter2])
        self[(-iter1-1), iter2] = Piece.new([(SIZE-iter1-1),iter2])
      end
    end
    populate_empty_pieces
  end

  def populate_empty_pieces
    @grid.each_with_index do |row,i|
      row.map!.with_index do |square, j|
        if square.nil?
          square = EmptyPiece.new([i,j])
        else
          square
        end
      end
    end
  end

  def [](i, j)
    @grid[i][j]
  end

  def []=(i, j, value)
    @grid[i][j] = value
  end

  def rows
    @grid
  end

  def move(start, end_pos)
    self[*start].update_pos
    self[*end_pos] = self[*start]
    self[*start] = nil

    # raise NoPieceError
    # raise EndPosError
  end

end

class NoPieceError < StandardError
end

class EndPosError < StandardError
end
