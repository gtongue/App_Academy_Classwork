class Array
  def my_uniq
    arr = []
    self.each do |el|
      arr << el if !arr.include?(el)
    end
    arr
  end

  def two_sum
    arr = []
    self.each_with_index do |el , i|
      (i+1..self.length-1).each do |j|
        arr << [i,j] if self[i] + self[j] == 0
      end
    end
    arr
  end


end

def my_transpose(arr)
  transposed = []

  (0..arr.length-1).each do |i|
    new_arr = []
    (0..arr.length-1).each do |j|
      new_arr.concat([arr[j][i]])
    end
    transposed << new_arr
  end
  transposed
end

def stock_picker(prices)
  max = 0
  max_index = []
  prices.each_index do |i|
    (i+1..prices.length-1).each do |j|
      if prices[j] - prices[i] > max
        max_index = [i,j]
        max = prices[j] - prices[i]
      end
    end
  end

  max_index
end
