require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'


class LRUCache
  attr_reader :count

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
      update_node!(@map[key])
    else
      calc!(key)
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    node = @store.append(key, val)
    @map[key] = node
    eject! if @map.count > @max
    val
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.next.prev = node.prev
    node.prev.next = node.next
    node.prev = @store.last
    node.next = @store.last.next
    node.prev.next = node
    node.next.prev = node
    node.val
   end

  def eject!
    eject_node = @store.first
    @store.remove(@store.first.key)
    @map.delete(eject_node.key)
  end
end
