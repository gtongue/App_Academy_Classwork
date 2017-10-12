require_relative 'piece.rb'
require 'byebug'
class Board
  attr_reader :board
  attr_accessor :current_player

  def initialize
    @current_player = nil

    @board = Array.new(8) {Array.new(8) {NullPiece.instance}}
    color = :black
    [1,6].each do |row|
      (0..7).each do |col|
        self[[row, col]] = Pawn.new([row,col], self, color)
      end
      color = :light_white
    end
    color = :black
    [[0,0],[7,0],[0,7],[7,7]].each do |pos|
      self[pos] = Rook.new(pos,self, color)
      if color == :black
        color = :light_white
      else
        color = :black
      end
    end
    color = :black
    [[0,1],[7,1],[0,6],[7,6]].each do |pos|
      self[pos] = Knight.new(pos,self, color)
      if color == :black
        color = :light_white
      else
        color = :black
      end
    end
    color = :black
    [[0,2],[7,2],[0,5],[7,5]].each do |pos|
      self[pos] = Bishop.new(pos,self, color)
      if color == :black
        color = :light_white
      else
        color = :black
      end
    end
    color = :black
    [[0,4],[7,4]].each do |pos|
      self[pos] = King.new(pos,self, color)
      color = :light_white
    end
    color = :black
    [[0,3],[7,3]].each do |pos|
      self[pos] = Queen.new(pos,self, color)
      color = :light_white
    end
  end

  def dup
    new_board = Board.new
    self.board.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        new_piece = self[[row_idx,col_idx]]
        if !new_piece.is_a?(NullPiece)
          piece_class = new_piece.class
          duplicate_piece =
            piece_class.new(new_piece.pos.dup, new_board, new_piece.color)
          new_board[[row_idx,col_idx]] = duplicate_piece
        else
          new_board[[row_idx,col_idx]] = new_piece
        end
      end
    end
    new_board
  end

  def move_piece(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.instance
    self[end_pos].pos = end_pos
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    @board[row][col] = piece
  end

  def in_bounds?(pos)
    pos.all? { |el| el.between?(0, @board.length - 1) }
  end

  def in_check?(color)
    enemy_pieces = @board.flatten.select do |el|
      el.color != color && !el.is_a?(NullPiece)
    end

    king = @board.flatten.select do |el|
      el.is_a?(King) && el.color == color
    end

    king_pos = king.first.pos

    enemy_pieces.each do |piece|
      moves = piece.moves
      return true if moves.include?(king_pos)
    end

    false
  end

  def checkmate?(color)
    pieces = @board.flatten.select { |el| el.color == color }
    pieces.each do |piece|
      piece_moves = piece.moves
      duplicate_board = self.dup
      piece_moves.each do |move_pos|
        temp_piece = duplicate_board[move_pos]
        duplicate_board.move_piece(piece.pos, move_pos)
        if !duplicate_board.in_check?(color)
          return false
        end
        duplicate_board[piece.pos], duplicate_board[move_pos] =
          duplicate_board[move_pos], temp_piece
      end
    end
    true
  end

end
