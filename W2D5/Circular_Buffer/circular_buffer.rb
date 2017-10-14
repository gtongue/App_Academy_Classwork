class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class CircularBuffer
  include Enumerable

  def initialize(capacity)
    @store = StaticArray.new(capacity)
    @count = 0
    @start_idx = 0
    @end_idx = capacity
  end

  def [](i)
    idx = i + start_idx
    idx -= end_idx if idx >= end_idx
    @store[idx]
  end

  def []=(i, val)
    idx = i + start_idx
    idx -= end_idx if idx >= end_idx
    @store[idx] = val
  end

  def push(val)
    @store[@end_idx] = val
    @count += 1
    val
  end

  def each
    i = 0
    until i == @store.length
      yield @store[i]
      i += 1
    end
  end

  alias_method :<<, :push
end
