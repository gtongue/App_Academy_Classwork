require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarian's algorithms

# Khan's
def topological_sort(vertices)
  result = []
  queue = []
  in_edges_lengths = hash_in_edges(vertices)
  vertices.each do |vertex|
    if vertex.in_edges.empty?
      queue << vertex
    end
  end  
  until queue.empty?
    vertex = queue.shift
    result << vertex
    vertex.out_edges.each do |edge|
      to_vertex = edge.to_vertex
      in_edges_lengths[to_vertex]-=1
      if in_edges_lengths[to_vertex] == 0
        queue << to_vertex
      end
    end
  end
  return [] if check_cycle(in_edges_lengths)
  result
end

#Tarjan's my cyclical solution is inefficient
def topological_sort_tarjan(vertices)
  result = []
  visited = Hash.new(false)
  initial_verts = []
  vertices.each do |vertex|
    if vertex.in_edges.empty?
      initial_verts << vertex
    end
  end
  until initial_verts.empty?
    vertex = initial_verts.pop
    cyclic = visit(vertex, result, visited, [])
    if cyclic == true
      result = []
      break
    end
  end
  result
end

private

def visit(vertex, result, visited, collision_array)
  if collision_array.include?(vertex)
    return true
  elsif !visited[vertex]
    vertex.out_edges.each do |edge|
      collision_array << vertex
      cyclic = visit(edge.to_vertex, result, visited, collision_array.clone())
      return true if cyclic == true
    end
    visited[vertex] = true
    result.unshift(vertex)
  end
end

def hash_in_edges(vertices)
  hash = Hash.new(0)
  vertices.each do |vertex|
    hash[vertex] = vertex.in_edges.length
  end
  hash
end

def check_cycle(in_edges_lengths)
  in_edges_lengths.each do |vert, val|
    return true if val != 0
  end
  return false
end

