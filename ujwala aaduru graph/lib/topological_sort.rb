require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms
# khan's algorithm
def topological_sort(vertices)
  vertex_queue = []
  sorted_queue = []

  vertex_count = {}

  #vertex queue has vertex which do not have any in_edges
  vertices.each do |vertex|
    vertex_count[vertex] = vertex.in_edges.count
    vertex_queue << vertex if vertex.in_edges.empty?
  end

  # while !vertex_queue.empty?
  until vetex_queue.empty?
    new_vertex = vertex_queue.shift
    sorted_queue << new_vertex

    new_vertex.out_edges.each do |out|
      to_vertex = out.to_vertex

      vertex_count[to_vertex] -= 1
      vertex_queue << to_vertex if vertex_count[to_vertex] == 0
    end
  end
  sorted_queue
end
