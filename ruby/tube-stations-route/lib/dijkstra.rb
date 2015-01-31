require 'priority_queue'

class Dijkstra
  def initialize(graph)
    @graph = graph
  end

  def shortest_path(start, finish)
    infinity = Float::INFINITY
    distances = {}
    previous = {}
    nodes = PriorityQueue.new

    @graph.vertices.each do | vertex, value |
      if vertex == start
        distances[vertex] = 0
        nodes[vertex] = 0
      else
        distances[vertex] = infinity
        nodes[vertex] = infinity
      end
      previous[vertex] = nil
    end

    while nodes
      smallest = nodes.delete_min_return_key

      if smallest == finish
        path = []
        while previous[smallest]
          path << smallest
          smallest = previous[smallest]
        end
        path << start
        return path.reverse
      end

      if smallest == nil or distances[smallest] == infinity
        break
      end

      @graph.vertices[smallest].each do | neighbor, value |
        alternative = distances[smallest] + @graph.vertices[smallest][neighbor]
        if alternative < distances[neighbor]
          distances[neighbor] = alternative
          previous[neighbor] = smallest
          nodes[neighbor] = alternative
        end
      end
    end
  end
end
