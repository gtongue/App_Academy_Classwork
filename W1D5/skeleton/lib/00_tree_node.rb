require "byebug"
class PolyTreeNode

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(new_parent)
    old_parent = @parent
    @parent = new_parent
    unless self.parent == nil
      self.parent.children << self unless self.parent.children.include?(self)
    end
    old_parent.children.delete(self) if old_parent && old_parent != new_parent
  end

  def add_child(child)
    child.parent = self
  end

  def remove_child(child)
    raise "Child not included in parents children" unless child.parent.children.include?(child)
    child.parent = nil
  end

  def dfs(target)
    return self if self.value == target
    self.children.each do |child|
      result = child.dfs(target)
      return result if result
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target
      node.children.each { |child| queue << child}
    end
    nil
  end
end

# n1 = PolyTreeNode.new("1")
# n2 = PolyTreeNode.new("2")
# n3 = PolyTreeNode.new("3")
# n4 = PolyTreeNode.new("4")
# n5 = PolyTreeNode.new("5")
# n6 = PolyTreeNode.new("6")
# n7 = PolyTreeNode.new("7")
# # connect n3 to n1
# n4.parent = n2
# n5.parent = n2
#
# n6.parent = n3
# n7.parent = n3
#
# n2.parent = n1
# n3.parent = n1
#
# puts "BFS:"
# n1.bfs('7')
# puts
# puts "DFS:"
# n1.dfs('7')
# puts
