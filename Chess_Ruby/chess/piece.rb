require 'singleton'
require_relative 'piece_modules'


class Piece

  attr_reader :color
  attr_accessor :selected, :pos

  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
    @selected = false
  end

  def to_s
    "P"
  end

  def moves; end
  def move_dirs; end

  def valid_moves
    possible_moves = moves
    copy_board = @board.dup
    valid_moves = []
    possible_moves.each do |move|
      temp_piece = copy_board[move]
      copy_board.move_piece(@pos, move)
      unless copy_board.in_check?(@color)
        valid_moves << move
      end
      copy_board[@pos], copy_board[move] = copy_board[move], temp_piece
    end
    valid_moves
  end

end


class NullPiece < Piece
  include Singleton
  def initialize
  end
  def to_s
    " "
  end
end

class Bishop < Piece
  include SlidingPiece

  def move_dirs
    [:diagonal]
  end

  def to_s
    "♝"
  end


end

class Rook < Piece
  include SlidingPiece

  def move_dirs
    [:horizontal, :vertical]
  end

  def to_s
    "♜"
  end
end

class Queen < Piece
  include SlidingPiece

  def move_dirs
    [:horizontal, :vertical, :diagonal]
  end

  def to_s
    "♛"
  end
end


class Knight < Piece
  include SteppingPiece

  def move_dirs
    [:knight_direction]
  end

  def to_s
    "♞"
  end
end

class King < Piece
  include SteppingPiece

  def move_dirs
    [:king_direction]
  end

  def to_s
    "♚"
  end



end


class Pawn < Piece
  include SteppingPiece

  def move_dirs
    [:pawn_direction]
  end

  def to_s
    "♟"
  end

end
