require 'dijkstra'
require 'graph'

describe Dijkstra do
  describe "processes dijkstra's algorithm" do
    it 'finds the shortest path between two nodes in a graph' do
      graph = Graph.new
      graph.add_vertex('A', {'B' => 7, 'C' => 8})
      graph.add_vertex('B', {'A' => 7, 'F' => 2})
      graph.add_vertex('C', {'A' => 8, 'F' => 6, 'G' => 4})
      graph.add_vertex('D', {'F' => 8})
      graph.add_vertex('E', {'H' => 1})
      graph.add_vertex('F', {'B' => 2, 'C' => 6, 'D' => 8, 'G' => 9, 'H' => 3})
      graph.add_vertex('G', {'C' => 4, 'F' => 9})
      graph.add_vertex('H', {'E' => 1, 'F' => 3})

      dijkstra = Dijkstra.new(graph)
      dijkstra.shortest_path('A', 'R').should be_nil
      dijkstra.shortest_path('A', 'H').should eq ['A', 'B', 'F', 'H']
      dijkstra.shortest_path('E', 'C').should eq ['E', 'H', 'F', 'C']
    end
  end
end
