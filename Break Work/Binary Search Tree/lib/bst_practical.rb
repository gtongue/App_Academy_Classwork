
def kth_largest(tree_node, k)
  arr = []
  k.times do 
    if tree_node == nil
      return arr.last
    end
    arr << tree_node
    tree_node = tree_node.right
  end
  debugger
  until tree_node == nil
    arr.push(tree_node)
    arr.shift
    tree_node = tree_node.right
  end
  arr.last
end

def maximum(tree_node)
  until tree_node.right == nil
    tree_node = tree_node.right
  end
  tree_node
end
