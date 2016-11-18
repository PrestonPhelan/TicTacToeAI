require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    current_node = TicTacToeNode.new(game.board, mark)

    current_node.children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
    end

    current_node.children.shuffle.each do |child|
      return child.prev_move_pos unless child.losing_node?(mark)
    end

    raise "No moves, something went wrong!"
  end
end
if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
