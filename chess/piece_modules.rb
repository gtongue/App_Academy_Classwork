require 'byebug'

module SlidingPiece
  def moves
    possible_dirs = move_dirs

    possible_moves = []
    possible_dirs.each do |direction|
      case direction
      when :horizontal
        row = @board.board[@pos[0]]
        index = @pos[1]
        while index < @board.board.length
          break if index >= @board.board.length - 1
          index += 1
          if row[index].color != @color
            possible_moves << [@pos[0], index]
            break
          end
          break unless row[index].is_a?(NullPiece)
          possible_moves << [@pos[0], index]
        end
        index = @pos[1]
        while index >= 0
          break if index <= 0
          index -= 1
          if row[index].color != @color
            possible_moves << [@pos[0], index]
            break
          end
          break unless row[index].is_a?(NullPiece)
          possible_moves << [@pos[0], index]
        end


      when :vertical

        col = @pos[1]
        index = @pos[0]
        while index < @board.board.length
          break if index >= @board.board.length - 1
          index += 1
          if @board[[index, col]].color != @color
            possible_moves << [index, col]
            break
          end
          break unless @board[[index, col]].is_a?(NullPiece)
          possible_moves << [index, col]
        end
        index = @pos[0]
        while index >= 0
          break if index <= 0
          index -= 1
          if @board[[index, col]].color != @color
            possible_moves << [index, col]
            break
          end
          break unless @board[[index, col]].is_a?(NullPiece)
          possible_moves << [index, col]
        end

      when :diagonal


        [[1,1],[1,-1],[-1,1],[-1,-1]].each do |diff|
          current_pos = @pos
          current_pos = [current_pos[0] + diff[0],current_pos[1] + diff[1]]
          while @board.in_bounds?(current_pos)
            if @board[current_pos].color != @color
              possible_moves << current_pos
              break
            end
            break unless @board[current_pos].is_a?(NullPiece)
            possible_moves << current_pos
            current_pos = [current_pos[0] + diff[0],current_pos[1] + diff[1]]
          end
        end
      end
    end
    possible_moves
 end
end

module SteppingPiece
  def moves
    #byebug
    direction = move_dirs
    possible_moves  = []
    case direction.first
    when :knight_direction
      diffs = [[2,1],[1,2],[2,-1], [-1,2], [-2,1], [-2,-1], [-1,-2], [1,-2]]
    when :king_direction
      diffs = [[0,1],[1,0],[1,1],[0,-1], [-1,0], [-1,1], [-1,-1], [1,-1]]
    when :pawn_direction
      if @pos[0] == 1 && @color == :magenta
        diffs = [[1,0], [2,0]]
      elsif @pos[0] == 6 && @color == :yellow
        diffs = [[-1,0],[-2,0]]
      elsif @color == :yellow
        diffs = [[-1,0]]
      elsif @color == :magenta
        diffs = [[1,0]]
      end
    end

    diffs.each do |dif|
      new_pos = [@pos[0] + dif[0], @pos[1] + dif[1]]
      possible_moves << new_pos if @board.in_bounds?(new_pos) && (@board[new_pos].is_a?(NullPiece) || @board[new_pos].color != @color)
    end
    possible_moves
  end
end
