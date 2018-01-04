require_relative 'heap'

def k_largest_elements(array, k)
    heap = BinaryMinHeap.new {|x,y| y <=> x}
    array.each {|val| heap.push(val)}
    k_largest = []
    while k != 0
        k_largest << heap.extract
        k -= 1
    end
    k_largest
end
