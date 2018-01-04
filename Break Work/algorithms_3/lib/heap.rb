require "byebug"

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[@store.length-1] = @store[@store.length-1], @store[0]
    val = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, &@prc)
    val
  end

  def peek
    @store.first
  end

  def push(val)
    @store << val
    BinaryMinHeap.heapify_up(@store, @store.length-1, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    index1 = parent_index * 2 + 1
    index2 = parent_index * 2 + 2
    children = []
    children << index1 if index1 < len
    children << index2 if index2 < len
    children
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    parent = (child_index - 1)/2
    parent
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new {|x, y| x <=> y}
    children_idxs = self.child_indices(len, parent_idx)
    parent = array[parent_idx]
    swapped = false
    new_parent_idx = parent_idx
    if children_idxs.length == 2
      first = prc.call(parent, array[children_idxs[0]])
      second = prc.call(parent, array[children_idxs[1]])
      if first == 1 && second == 1
        if prc.call(array[children_idxs[1]], array[children_idxs[0]]) == 1 
          array[parent_idx], array[children_idxs[0]] = array[children_idxs[0]], array[parent_idx]
          new_parent_idx = children_idxs[0]
          swapped = true
        else
          array[parent_idx], array[children_idxs[1]] =  array[children_idxs[1]], array[parent_idx]
          new_parent_idx = children_idxs[1]
          swapped = true
        end
      elsif first == 1 && second != 1
        array[parent_idx], array[children_idxs[0]] =  array[children_idxs[0]], array[parent_idx]
        new_parent_idx = children_idxs[0]
        swapped = true
      elsif second == 1 && first != 1
        array[parent_idx], array[children_idxs[1]] =  array[children_idxs[1]], array[parent_idx]
        new_parent_idx = children_idxs[1]
        swapped = true
      end
    elsif children_idxs.length == 1
      first = prc.call(parent, array[children_idxs[0]])
      if first == 1
        array[parent_idx], array[children_idxs[0]] =  array[children_idxs[0]], array[parent_idx]
        new_parent_idx = children_idxs[0]
        swapped = true
      end
    else
      return array
    end
    if swapped
      return self.heapify_down(array, new_parent_idx, len, &prc)
    else
      return array
    end
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new {|x, y| x <=> y}
    child = array[child_idx]
    begin
      parent_idx = self.parent_index(child_idx)
    rescue => exception
      return array
    end
    parent = array[parent_idx]
    if(prc.call(parent, child) == 1)
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
      self.heapify_up(array, parent_idx, len, &prc)
    else
      return array
    end
  end
end
