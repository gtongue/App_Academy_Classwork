# This class just dumbs down a regular Array to be statically sized.
class StaticArray
  def initialize(length)
    @store = Array.new(length)
  end

  # O(1)
  def [](index)
    validate!(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    validate!(index)
    @store[index] = value
  end

  def length
    @store.length
  end

  protected
  attr_accessor :store

  private 
  def validate!(i)
    raise "Index out of bounds" if !i.between?(0, @store.length - 1)
  end
end
