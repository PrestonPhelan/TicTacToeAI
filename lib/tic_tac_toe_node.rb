require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def prev_mark
    next_mover_mark == :x ? :o : :x
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = Array.new
    ##Iterate through empty positions
    board.rows.each_with_index do |row, idx|
      row.each_index do |idx2|
        pos = [idx, idx2]
        next unless board.empty?(pos)
        dup_board = board.dup
        dup_board[pos] = next_mover_mark

        children << TicTacToeNode.new(dup_board, prev_mark, pos)
      end
    end

    children
  end
end

if __FILE__ == $PROGRAM_NAME
  node = TicTacToeNode.new(Board.new, :x)

  node.children.each do |child|
    print child.board.rows
    puts ""
  end
end
