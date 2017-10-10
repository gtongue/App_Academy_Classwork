require_relative 'piece.rb'
require 'byebug'
class Board
  attr_reader :board

  def initialize
    @board = Array.new(8) {Array.new(8) {NullPiece.instance}}
    color = :magenta
    [1,6].each do |row|
      (0..7).each do |col|
        self[[row, col]] = Pawn.new([row,col], self, color)
      end
      color = :yellow
    end
    color = :magenta
    [[0,0],[7,0],[0,7],[7,7]].each do |pos|
      self[pos] = Rook.new(pos,self, color)
      if color == :magenta
        color = :yellow
      else
        color = :magenta
      end
    end
    color = :magenta
    [[0,1],[7,1],[0,6],[7,6]].each do |pos|
      self[pos] = Knight.new(pos,self, color)
      if color == :magenta
        color = :yellow
      else
        color = :magenta
      end
    end
    color = :magenta
    [[0,2],[7,2],[0,5],[7,5]].each do |pos|
      self[pos] = Bishop.new(pos,self, color)
      if color == :magenta
        color = :yellow
      else
        color = :magenta
      end
    end
    color = :magenta
    [[0,3],[7,3]].each do |pos|
      self[pos] = King.new(pos,self, color)
      color = :yellow
    end
    color = :magenta
    [[0,4],[7,4]].each do |pos|
      self[pos] = Queen.new(pos,self, color)
      color = :yellow
    end


  end


  def move_piece(start_pos, end_pos)
    raise StandardError if self[start_pos] == NullPiece.instance
    #raise StandardError when you cannot move the piece to this location (end_pos)
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
    pos.all? {|el| el.between?(0,@board.length - 1)}
  end

  def in_check(color)
    pieces = @board.flatten.select {|el| el.color != color && !el.is_a?(NullPiece)}
    king = @board.flatten.select {|el| el.is_a?(King) && el.color == color}
    king_pos = king.first.pos
    # byebug
    puts "kingpos: " + king_pos.to_s
    pieces.each do |piece|
      moves = piece.moves
      puts piece.class.to_s + " pos: " + piece.pos.to_s + " moves: " + moves.to_s
      return true if moves.include?(king_pos)
    end
    return false
  end
end
