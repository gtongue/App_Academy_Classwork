require_relative "graph"
require_relative "topological_sort"
# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

def install_order(arr)
    hash = Hash.new { |h, k| h[k] = [-1, []]}
    max_id = -1
    arr.each do |package|
        max_id = package[0] if package[0] > max_id
        if hash[package[0]][0] != -1
            hash[package[0]][1] << package[1]
        else
            vertex = Vertex.new(package[0])
            hash[package[0]][0] = vertex
            hash[package[0]][1] << package[1]
        end
    end
    (1..max_id).each do |el|
        if hash[el][0] == -1
            hash[el][0] = Vertex.new(el)
        end
    end
    hash.each do |k, v|
        v[1].each do |dependency|
            to_vertex = v[0]
            from_vertex = hash[dependency][0]
            Edge.new(from_vertex, to_vertex)
        end
    end
    vertices = hash.values.map {|value| value[0]}
    order = topological_sort(vertices)
    result = order.map{|vertex| vertex.value}
    result
end