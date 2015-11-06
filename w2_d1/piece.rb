SIZE = 8

class Piece
  # attr_reader :pos

  def initialize(pos)
    @pos = pos
  end

  def to_s
    "P "
  end

  def update_pos(sel_pos_array, cur_pos_array)
     
  end

  def moves
  end

end

class SlidingPiece < Piece

  def moves
    moves = []
    i = 0
    while i < SIZE
      next_move_set = []
      move_dirs.each do |row|
        next_move_set << []
        row.each do |el|
          next_move_set.last << el * i
        end
      i += 1
      end
      moves += next_move_set
    end
    moves

  #   moves = Array.new(SIZE) {Array.new(move_dirs.length/2)}
  #   move_dirs.each_with_index do |dir,i|
  #     dir.each_with_index do |el,j|
  #       (SIZE-1).times do |k|
  #         moves[i][j] = el * (k+1)
  #       end
  #     end
  #   end
  #   moves.each do |i|
  #     i.map {|x| x[0] + pos[0]}
  #   end
  # end
  end
end

class Bishop < SlidingPiece
  def move_dirs
    move_dirs = [[1,1],[1,-1],[-1,1],[-1,-1]]
  end

  # def moves
end

class Rook < SlidingPiece
  def move_dirs
    move_dirs = [[1,0],[-1,0],[0,1],[0,-1]]
  end

end

class Queen < SlidingPiece
  def move_dirs
    [[1,0],[-1,0],[0,1],[0,-1],[1,1],[1,-1],[-1,1],[-1,-1]]
  end

end

class SteppingPiece < Piece


end













class EmptyPiece < Piece
  def to_s
    "  "
  end
end
