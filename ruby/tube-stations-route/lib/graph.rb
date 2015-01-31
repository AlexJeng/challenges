
class Graph
  def initialize
    @vertices = {}
  end

  def add_vertex(node, edges)
    @vertices[node] = edges
  end

  def vertices
    @vertices
  end

  def == (other)
    if other.class == self.class
      @vertices == other.vertices
    else
      false
    end
  end

  def to_s
    @vertices.inspect
  end
end
