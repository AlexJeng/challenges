require_relative '../lib/graph'

class Parser
  def createGraph(file)
    graph = Graph.new
    node = nil
    edges = {}

    File.readlines(file).each do |line|
      station1, station2 = line.strip.split(',')

      if node == station1
        edges[station2] = 1
      else
        graph.add_vertex(node, edges) if node != nil
        edges = {}
        edges[station2] = 1
      end
      node = station1
    end

    graph
  end
end
