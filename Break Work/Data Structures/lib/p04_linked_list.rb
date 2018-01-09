class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next if !@prev.nil?
    @next.prev = @prev if !@next.nil?
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new(nil, nil)
    @tail = Node.new(nil, nil)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    first == @tail && last == @head
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.next = @tail
    new_node.prev = @tail.prev
    @tail.prev.next = new_node
    @tail.prev = new_node
  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val
        return val
      end
    end
    nil
  end

  def remove(key)
    self.each do |node|
      if node.key == key
        node.remove
        return key
      end
    end
    nil
  end

  def each
    current_node = @head.next
    until current_node == @tail
      yield current_node
      current_node = current_node.next
    end
  end

  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
