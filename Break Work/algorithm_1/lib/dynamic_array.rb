require_relative "static_array"
require "byebug"

class DynamicArray
  attr_reader :length
  include Enumerable

  def initialize(length = 8)
    @store = StaticArray.new(length)
    @length = 0
  end

  # O(1)
  def [](i)
    raise "index out of bounds" if i > @length - 1
    i = i + @length if i < 0
    raise "index out of bounds" if  i < 0
    @store[i]
  end

  # O(1)
  def []=(i, value)
    while i > @length-1
      self.push(nil)
    end
    i =  i + @length if i < 0
    @store[i] = value
  end

  def each
    i = 0
    until i == @store.length
      yield @store[i]
      i += 1
    end
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    return_val = @store[@length-1]
    if return_val
      @length -= 1
      @store[@length] = nil
      return return_val
    end
    nil
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length >= @store.length
    @store[@length] = val
    @length += 1
    val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == 0
    shift_val = @store[0]
    @length -= 1
    @store[0] = nil
    i = 1
    until i == @length + 1
      @store[i-1] = @store[i]
      i += 1
    end
    shift_val
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    p @store
    resize! if @length == @store.length
    i = @length
    until i == 0
      self[i] = self[i-1]
      i -= 1
    end
    self[0] = val
    @length += 1
    val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  def capacity
    @store.length
  end
  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_array = StaticArray.new(@store.length * 2)
    self.each_with_index do |el, i|
      new_array[i] = el
    end
    @store = new_array
  end
end
