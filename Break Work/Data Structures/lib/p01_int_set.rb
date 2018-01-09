class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    return false if include?(num)
    @store[num] = true
    num
  end

  def remove(num)
    validate!(num)
    return nil if !include?(num)
    @store[num] = false
    num
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
    raise "Out of bounds" if num > @store.length - 1 || num < 0
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    return false if include?(num)
    self[num] << num
    num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return false if include?(num)
    @count += 1
    self[num] << num
    resize! if @count > @store.length
    num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % @store.length]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(@store.length * 2) { Array.new }
    @store.flatten.each do |el|
        new_store[el % new_store.length] << el
    end
    @store = new_store
  end
end
