require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    node = self[key]
    if node
      @store[bucket(key)].update(key,val)
    else
      @count += 1
      @store[bucket(key)].append(key, val)
      resize! if @count > @store.length
    end
    val
  end

  def get(key)
    @store[key.hash % @store.length].get(key)
  end

  def delete(key)
    return nil unless include?(key)
    @count -= 1
    @store[bucket(key)].remove(key)
  end

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield [node.key, node.val]
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(@store.length * 2) { LinkedList.new }
    self.each do |key, val|
      new_store[key.hash % new_store.length].append(key, val)
    end
    @store = new_store
  end

  def bucket(key)
    key.hash % @store.length
  end
end
