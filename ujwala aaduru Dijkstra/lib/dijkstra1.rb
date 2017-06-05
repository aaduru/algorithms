require_relative 'graph'

# O(|V|**2 + |E|).
def dijkstra1(source)
  shortest_paths = {}
  possible_paths = { source => { cost: 0, edge: nil } }

  # p possible_paths
  until possible_paths.empty?
    current_vertex, cost = possible_paths.min_by do |(vertex, cost)|
      cost[:cost]
    end
    # p current_vertex
    # p cost
    shortest_paths[current_vertex] = possible_paths[current_vertex]
    possible_paths.delete(current_vertex)

    vertex_cost = shortest_paths[current_vertex][:cost]
    # p vertex_cost
    current_vertex.out_edges.each do |vertex|
      to_vertex = vertex.to_vertex

      next if shortest_paths.has_key?(to_vertex)

      total_cost = vertex_cost + vertex.cost
      # p total_cost
      next if possible_paths.has_key?(to_vertex) && possible_paths[to_vertex][:cost] <= total_cost

      possible_paths[to_vertex] = {
        cost: total_cost,
        edge: vertex
      }
    end
  end
  # p shortest_paths
  shortest_paths
end
