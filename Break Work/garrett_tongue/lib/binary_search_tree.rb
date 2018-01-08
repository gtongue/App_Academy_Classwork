# There are many ways to implement these methods, feel free to add arguments 
# to methods as you see fit, or to create helper methods.
require_relative "bst_node"
require "byebug"

class BinarySearchTree
  attr_accessor :root
  def initialize
    @root = nil
  end

  def insert(value)
    parent = find_insert_parent(value)
    if parent == nil
      @root = BSTNode.new(value)
    else
      if value > parent.value
        parent.right = BSTNode.new(value)
        parent.right.parent = parent
      else
        parent.left = BSTNode.new(value)
        parent.left.parent = parent
      end
    end
  end

  def find(value, tree_node = @root)
    if value == tree_node.value
      return tree_node
    elsif value > tree_node.value
      return nil unless tree_node.right
      find(value, tree_node.right)
    else
      return nil unless tree_node.left
      find(value, tree_node.left)
    end
  end

  def delete(value)
    node = find(value)
    if !node.parent
      @root = nil
    elsif !node.left && !node.right
      if node.parent.value < value
        node.parent.right = nil
      else
        node.parent.left = nil
      end
    elsif !node.left && node.right
      if node.parent.value < value
        node.parent.right = node.right
      else
        node.parent.left = node.right
      end
    elsif node.left && !node.right
      if node.parent.value < value
        node.parent.right = node.left
      else
        node.parent.left = node.left
      end
    else
      debugger
      maximum = maximum(node.left)
      maximum.parent.right = nil
      maximum.parent = node.parent
      maximum.right = node.right
      maximum.right.parent = maximum
      maximum.left = node.left
      maximum.left.parent = maximum
      if maximum.parent.value < value
        maximum.parent.right = maximum
      else
        maximum.parent.left = maximum
      end
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    until tree_node.right == nil
      tree_node = tree_node.right
    end
    tree_node
  end

  def depth(tree_node = @root)
  end 

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end


  private
  # optional helper methods go here:
  def find_insert_parent(val, tree_node = @root)
    if tree_node == nil
      return tree_node
    else
      if tree_node.value < val
        if tree_node.right
          return find_insert_parent(val, tree_node.right)
        else
          return tree_node
        end
      else
        if tree_node.left
          return find_insert_parent(val, tree_node.left)
        else
          return tree_node
        end
      end
    end
  end
end
