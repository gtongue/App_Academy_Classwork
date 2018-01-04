require_relative "heap"

class Array
  def heap_sort!
    heap = BinaryMinHeap.new
    self.each {|val| heap.push(val)}
    sorted = []
    i = 0
    while heap.peek != nil
      self[i] = heap.extract
      i += 1
    end
  end
end
