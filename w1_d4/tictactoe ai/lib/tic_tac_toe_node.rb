require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)

    if @board.over?
      return false if @board.winner.nil?
      return @board.winner != evaluator
    end

    if @next_mover_mark == evaluator
      return children.all? { |child| child.losing_node?(evaluator)}
    else
      return children.any? { |child| child.losing_node?(evaluator)}
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      return @board.winner == evaluator
    end

    if @next_mover_mark == evaluator
      return children.any? { |child| child.winning_node?(evaluator)}
    else
      return children.all? { |child| child.winning_node?(evaluator)}
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    arr = []

    opposite = (@next_mover_mark == :o ? :x : :o)

    @board.rows.each_with_index do |row, x|
      row.each_index do |y|
        if @board.rows[x][y].nil?
          duplicate = @board.dup

          duplicate.rows[x][y] = @next_mover_mark

          arr << TicTacToeNode.new(duplicate, opposite, [x,y])
        end
      end
    end

    arr
  end
end
