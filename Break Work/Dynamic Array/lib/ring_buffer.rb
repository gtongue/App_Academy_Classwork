require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0;
    @start_idx = 0;
  end

  # O(1)
  def [](i)
    raise "index out of bounds" if i > @length - 1
    i = i + @length if i < 0
    raise "index out of bounds" if  i < 0
    @store[i]
  end

  # O(1)
  def []=(i, val)
  end

  # O(1)
  def pop
  end

  # O(1) ammortized
  def push(val)

  end

  # O(1)
  def shift
  end

  # O(1) ammortized
  def unshift(val)
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def resize!
  end
end
