require_relative "00_tree_node.rb"

class KnightPathFinder
  def initialize(pos)
    @initial_pos = pos
    @visited_positions = Hash.new(false)
    @root = PolyTreeNode.new(@initial_pos)
    @visited_positions[@initial_pos] = true
    @board_size = 8
    build_move_tree
  end

  def valid_moves(pos)
    deltas = [[1,2],[2,1],[-2,1],[-1,2],[-1,-2],[-2,-1],[2,-1],[1,-2]]
    valid = []
    deltas.each do |delta|
      new_pos = [delta[0]+pos[0], delta[1] + pos[1]]
      valid << new_pos if new_pos.all? {|el| el.between?(0,@board_size-1)}
    end
    valid
  end

  def build_move_tree
    queue = [@root]
    until queue.empty?
      node = queue.shift
      new_moves = new_move_positions(node.value)
      new_moves.each do |new_move|
        child = PolyTreeNode.new(new_move)
        child.parent = node
        queue << child
      end
    end
    @root
  end

  def find_path(pos)
    current_node = @root.bfs(pos)
    return nil if current_node.nil?
    path = [current_node.value]
    while current_node.value != @root.value
      current_node = current_node.parent
      path.unshift(current_node.value)
    end
    path
  end

  private

  def new_move_positions(pos)
    valid = valid_moves(pos)
    valid.reject! {|el| @visited_positions[el] == true}
    valid.each {|el| @visited_positions[el] = true}
    valid
  end
end
