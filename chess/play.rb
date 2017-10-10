require_relative 'board.rb'
require_relative 'display.rb'


b = Board.new
d = Display.new(b)

selected_pos = []
while true
  pos = d.render
  if pos != nil && selected_pos.empty?
    selected_pos = pos
    b[selected_pos].selected = true
  elsif pos != nil
    b.move_piece(selected_pos, pos)
    b[pos].selected = false
    selected_pos = []
  end
end
