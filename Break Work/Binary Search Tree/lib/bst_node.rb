class BSTNode
  attr_accessor :left, :right, :value, :parent
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
    @parent = nil
  end

  def to_s
    return "value: #{@value}, left: #{@left.value}, right: #{@right.value}, parent: #{@parent.value}"
  end
end
