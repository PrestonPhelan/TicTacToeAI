require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def other_mark(mark)
    mark == :x ? :o : :x
  end

  def losing_node?(evaluator)
    ##Base Case
    return true if board.winner == other_mark(evaluator)
    return false if board.tied? || board.winner == evaluator

    if next_mover_mark == evaluator
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    return true if board.winner == evaluator
    return false if board.tied? || board.winner == other_mark(evaluator)

    if next_mover_mark == evaluator
      children.any? { |child| child.winning_node?(evaluator) }
    else
      children.all? { |child| child.winning_node?(evaluator) }
    end
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

        new_node = TicTacToeNode.new(dup_board, other_mark(next_mover_mark), pos)
        children << new_node
      end
    end

    children
  end
end

if __FILE__ == $PROGRAM_NAME
  node = TicTacToeNode.new(Board.new, :x)

  # node.children.each do |child|
  #   print child.board.rows
  #   puts " #{child.next_mover_mark}"
  # end

  puts "Start is a winning node? #{node.winning_node?(:x)}"
  puts "Start is a losing node? #{node.losing_node?(:x)}"
end
