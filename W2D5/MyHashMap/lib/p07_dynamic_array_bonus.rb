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

class DynamicArray
  attr_reader :count
  include Enumerable

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i > @count-1
    i =  i + @count if i < 0
    return nil if i < 0
    @store[i]
  end

  def []=(i, val)
    while i > @count-1
      self.push(nil)
    end
    i =  i + @count if i < 0
    @store[i] = val;
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.each do |el|
      return true if el == val
    end
    false
  end

  def push(val)
    resize! if @count >= @store.length
    @store[@count] = val
    @count += 1
    val
  end

  def unshift(val)
    resize! if @count+1 >= @store.length
    i = @count
    until i == 0
      self[i] = self[i-1]
      i -= 1
    end
    self[0] = val
    @count += 1
    val
  end

  def pop
    return nil if @count == 0
    return_val = @store[@count-1]
    if return_val
      @count -= 1
      @store[@count] = nil
      return return_val
    end
    nil
  end

  def shift
    return nil if @count == 0
    shift_val = @store[0]
    @count -= 1
    @store[0] = nil
    i = 1
    until i == @count + 1
      @store[i-1] = @store[i]
      i += 1
    end
    shift_val
  end

  def first
    @store[0]
  end

  def last
    @store[@count-1]
  end

  def each
    i = 0
    until i == @store.length
      yield @store[i]
      i += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    self.each_with_index do |el, i|
      return false if el != other[i]
      i += 1
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_array = StaticArray.new(@store.length * 2)
    self.each_with_index do |el, i|
      new_array[i] = el
    end
    @store = new_array
  end
end
