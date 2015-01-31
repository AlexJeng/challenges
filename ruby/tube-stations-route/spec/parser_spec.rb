require 'graph'
require 'parser'

describe Parser do
  let(:parser) { described_class.new }

  describe 'parses London tube stations file' do
    context 'create a graph with London tube stations data' do
      it 'with one station to another station' do
        graph = Graph.new
        graph.add_vertex('Acton_Central<National_Rail_Line>', {'Kensal_Rise<National_Rail_Line>' => 1})
        parser.createGraph('spec/tube/Tube1.txt').should eq graph
      end

      it 'with one station to two stations' do
        graph = Graph.new
        graph.add_vertex('Acton_Central<National_Rail_Line>', {'Kensal_Rise<National_Rail_Line>' => 1, 'South_Acton<National_Rail_Line>' => 1})
        parser.createGraph('spec/tube/Tube2.txt').should eq graph
      end

      it 'with two station' do
        graph = Graph.new
        graph.add_vertex('Acton_Central<National_Rail_Line>', {'Kensal_Rise<National_Rail_Line>' => 1, 'South_Acton<National_Rail_Line>' => 1})
        graph.add_vertex('Acton_Town<District_Line>', {'Ealing_Common<District_Line>' => 1})
        parser.createGraph('spec/tube/Tube3.txt').should eq graph
      end
    end
  end
end
