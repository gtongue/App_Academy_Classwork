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

  def moves
    #return array of possible moves
  end

  def move_dirs
    [:king_direction]
  end
end


class NullPiece < Piece
  include Singleton
  def initialize
  end
  def to_s
    "#"
  end
end

class Bishop < Piece
  include SlidingPiece

  def move_dirs
    [:diagonal]
  end

  def to_s
    "B"
  end


end

class Rook < Piece
  include SlidingPiece

  def move_dirs
    [:horizontal, :vertical]
  end

  def to_s
    "R"
  end
end

class Queen < Piece
  include SlidingPiece

  def move_dirs
    [:horizontal, :vertical, :diagonal]
  end

  def to_s
    "Q"
  end
end


class Knight < Piece
  include SteppingPiece

  def move_dirs
    [:knight_direction]
  end

  def to_s
    "H"
  end
end

class King < Piece
  include SteppingPiece

  def move_dirs
    [:king_direction]
  end

  def to_s
    "K"
  end



end


class Pawn < Piece
  include SteppingPiece

  def move_dirs
    [:pawn_direction]
  end

  def to_s
    "P"
  end

end
