require_relative "board.rb"
require_relative "cursor.rb"
require "colorize"
class Display

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], @board)
  end

  def render
    # system('clear')
    puts "In check?: " + @board.in_check(:magenta).to_s
    puts '________________________________________________________'
    @board.board.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        current_pos = [row_idx,col_idx]
        piece = @board[current_pos]
        if current_pos == @cursor.cursor_pos
          print ' | ' + @board[current_pos].to_s.colorize(:cyan) + ' | '
        elsif piece.selected
          print ' | ' + @board[current_pos].to_s.colorize(:red) + ' | '
        else
          print' | ' + @board[current_pos].to_s.colorize(piece.color) + ' | '
        end
      end
      puts
      puts '________________________________________________________'
    end
    @cursor.get_input
  end

end
