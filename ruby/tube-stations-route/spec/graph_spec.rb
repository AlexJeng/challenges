require 'graph'

describe Graph do
  graph = Graph.new
  graph.add_vertex('A', {'B' => 7, 'C' => 8})

  describe 'a graph' do
    it 'is equal to other graph with same values' do
      other = Graph.new
      other.add_vertex('A', {'B' => 7, 'C' => 8})
      graph.should eq other
    end

    it 'is not equal to other graph with different values' do
      other = Graph.new
      other.add_vertex('A', {'B' => 7, 'C' => 9})
      graph.should_not eq other
    end

    it 'is not equal to other class' do
      other = {'A' => {'B' => 7, 'C' => 8}}
      graph.should_not eq other
    end
  end
end
