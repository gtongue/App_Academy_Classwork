require_relative 'board.rb'
require_relative 'display.rb'

class Game

  def initialize(player_one = "player one", player_two = "player two")
    @board = Board.new
    @display = Display.new(@board)
    player_one = HumanPlayer.new(player_one,:light_white, @display)
    player_two = HumanPlayer.new(player_two, :black, @display)
    @players = [player_one, player_two]
  end



  def play

    while @players.none? {|el| @board.checkmate?(el.color)}

      @board.current_player = @players.first

      until @players.first.play_turn; end

      @players.reverse!

    end

    @display.render
    if(@board.checkmate?(@players.first.color))
      puts "The winner is #{@players.first.name}!"
        .colorize(:color => @players.first.color, :background => :light_black)
    else
      puts "The winner is #{@players.last.name}!"
      .colorize(:color => @players.last.color, :background => :light_black)
    end

  end

  def play_turn
    @player_one.play_turn
  end

end


class HumanPlayer

  attr_reader :color, :name

  def initialize(name,color,display)
    @name = name
    @color = color
    @display = display
  end


  def play_turn

    selected = nil
    while selected.nil?
      @display.render
      selected = @display.cursor.get_input
      selected = nil unless selected.nil? || @display.board[selected].color == @color
    end

    @display.board[selected].selected = true

    valid_moves = @display.board[selected].valid_moves
    new_selected = nil

    while new_selected.nil?
      @display.render
      new_selected = @display.cursor.get_input
      unless new_selected.nil? || valid_moves.include?(new_selected) || new_selected == selected
        new_selected = nil
      end
    end

    @display.board[selected].selected = false

    unless new_selected == selected
      @display.board.move_piece(selected, new_selected)
      return true
    else
      return false
    end

  end


end


if __FILE__ == $PROGRAM_NAME

  puts "Welcome to chess"
  puts "Please enter player one's name: "
  player_one = gets.chomp
  puts "Please enter player two's name: "
  player_two = gets.chomp
  game = Game.new(player_one, player_two)
  game.play
end
