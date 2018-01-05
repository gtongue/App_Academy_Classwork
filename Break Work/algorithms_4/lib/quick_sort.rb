require "byebug";
class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    if array.length <= 1
      return array
    end
    pivot_idx = (rand * array.length).to_i
    pivot_val = array[pivot_idx]
    array.delete_at(pivot_idx)
    left = []
    right = []
    array.each do |el|
      if el > pivot_val
        right << el
      else
        left << el
      end
    end
    return self.sort1(left) + [pivot_val] + self.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return if length <= 1
    pivot_idx = self.partition(array, start, length, &prc)
    self.sort2!(array, start, pivot_idx - start, &prc)
    self.sort2!(array, pivot_idx + 1, length - pivot_idx - 1, &prc)
  end
  
  def self.partition(array, start, length, &prc)
    prc ||= Proc.new {|x, y| x <=> y}
    # pivot_idx = (rand * (length-start)).to_i + start
    # TODO Random pivot
    pivot_idx = start
    end_idx = start + length

    pivot_val = array[pivot_idx]

    current_idx = pivot_idx
    i = start + 1

    array[start+1...end_idx].each do |val|
      if prc.call(val, pivot_val) == -1
        if current_idx + 1 != i 
          array[current_idx+1], array[i] = array[i], array[current_idx + 1]
        end
        current_idx += 1
      end
      i += 1
    end
    array[start], array[current_idx] = array[current_idx], array[start]
    return current_idx
  end
end
