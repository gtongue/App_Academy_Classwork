require_relative "board.rb"
require_relative "cursor.rb"
require "colorize"
class Display

  attr_accessor :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], @board)
  end

  def render
    system('clear')
    player_color = @board.current_player.color
    puts "Current Player: #{@board.current_player.name}"
      .colorize(:color => player_color, :background => :light_black)

    if @board.in_check?(@board.current_player.color)
      puts "In Check!".colorize(:color => player_color, :background => :light_black)
    end

    selected_piece = @board.board.flatten.select {|el| el.selected}
    valid_moves = []

    unless selected_piece.is_a?(NullPiece) || selected_piece.empty?
      valid_moves = selected_piece.first.valid_moves
    end

    current_color = :white
    puts
    print_color = nil
    print_background = nil
    @board.board.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        current_pos = [row_idx,col_idx]
        piece = @board[current_pos]
        if current_pos == @cursor.cursor_pos
          print_color = piece.color
          print_background = :cyan
        elsif piece.selected
          print_color = :red
          print_background = current_color
        elsif valid_moves.include?(current_pos)
          print_color = piece.color
          print_background = :green
        else
          print_color = piece.color
          print_background = current_color
        end
        print (' ' + @board[current_pos].to_s + '  ')
          .colorize(:color => print_color, :background => print_background)
        if current_color == :white
          current_color = :light_black
        else
          current_color = :white
        end
      end
      if current_color == :white
        current_color = :light_black
      else
        current_color = :white
      end
      puts
    end
  end

end
