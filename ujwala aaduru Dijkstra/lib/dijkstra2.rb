require_relative 'graph'
require_relative 'priority_map'

# O(|V| + |E|*log(|V|))

def dijkstra2(source)
  shortest_paths = {}
  possible_paths = PriorityMap.new do |cost1, cost2|
    cost1[:cost] <=> cost2[:cost]
  end
  possible_paths[source] = { cost: 0, edge: nil }

  until possible_paths.empty?
    current_vertex, cost = possible_paths.extract
    shortest_paths[current_vertex] = cost

    vertex_cost = shortest_paths[current_vertex][:cost]

    current_vertex.out_edges.each do |vertex|
      to_vertex = vertex.to_vertex

      next if shortest_paths.has_key?(to_vertex)

      total_cost = vertex_cost + vertex.cost
      next if possible_paths.has_key?(to_vertex) && possible_paths[to_vertex][:cost] <= total_cost

      possible_paths[to_vertex] = {
        cost: total_cost,
        edge: vertex
      }
    end
  end

  shortest_paths
end
