require 'byebug'
module SlidingPiece
  VERTICAL_DIFFS = [[1,0],[-1,0]]
  HORIZONTAL_DIFFS = [[0,1],[0,-1]]
  DIAGONAL_DIFFS = [[1,1], [-1,1], [1,-1],[-1,-1]]

  def moves
    possible_dirs = move_dirs
    possible_moves = []
    diffs = []
    possible_dirs.each do |direction|
      case direction
      when :horizontal
        diffs.concat(HORIZONTAL_DIFFS)
      when :vertical
        diffs.concat(VERTICAL_DIFFS)
      when :diagonal
        diffs.concat(DIAGONAL_DIFFS)
      end
    end

    diffs.each do |diff|
      current_pos = @pos.dup
      current_pos = [current_pos[0] + diff[0],current_pos[1] + diff[1]]

      while @board.in_bounds?(current_pos)
        if !@board[current_pos].is_a?(NullPiece) && @board[current_pos].color != @color
          possible_moves << current_pos
          break
        elsif !@board[current_pos].is_a?(NullPiece) && @board[current_pos].color == @color
          break
        else
          possible_moves << current_pos
          current_pos = [current_pos[0] + diff[0],current_pos[1] + diff[1]]
        end
      end

    end
    possible_moves
  end
end


module SteppingPiece

  KING_DIFFS = [[0,1],[1,0],[1,1],[0,-1], [-1,0], [-1,1], [-1,-1], [1,-1]]
  KNIGHT_DIFFS = [[2,1],[1,2],[2,-1], [-1,2], [-2,1], [-2,-1], [-1,-2], [1,-2]]

  def moves
    #byebug

    direction = move_dirs
    possible_moves  = []
    case direction.first
    when :knight_direction
      diffs = KNIGHT_DIFFS
    when :king_direction
      diffs = KING_DIFFS
    when :pawn_direction
      if @pos[0] == 1 && @color == :black
        diffs = [[1,0], [2,0]]
        attack_diffs = [[1,-1],[1,1]]
      elsif @pos[0] == 6 && @color == :light_white
        diffs = [[-1,0],[-2,0]]
        attack_diffs = [[-1,-1],[-1,1]]
      elsif @color == :light_white
        diffs = [[-1,0]]
        attack_diffs = [[-1,-1],[-1,1]]
      elsif @color == :black
        diffs = [[1,0]]
        attack_diffs = [[1,-1],[1,1]]
      end
    end

    unless direction.include?(:pawn_direction)
      diffs.each do |dif|
        new_pos = [@pos[0] + dif[0], @pos[1] + dif[1]]
        if @board.in_bounds?(new_pos) && (@board[new_pos].is_a?(NullPiece) || @board[new_pos].color != @color)
          possible_moves << new_pos
        end
      end
    else
      diffs.each do |dif|
        new_pos = [@pos[0] + dif[0], @pos[1] + dif[1]]
        if @board.in_bounds?(new_pos) && @board[new_pos].is_a?(NullPiece)
          possible_moves << new_pos
        end
      end
      attack_diffs.each do |dif|
        new_pos = [@pos[0] + dif[0], @pos[1] + dif[1]]
        if @board.in_bounds?(new_pos) && !@board[new_pos].is_a?(NullPiece) && @board[new_pos].color != @color
          possible_moves << new_pos
        end
      end
    end
    possible_moves
  end
end
