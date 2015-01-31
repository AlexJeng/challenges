
module GraphicalEditor
  class Image
    DEFAULT_COLOR = 'O'

    def initialize(m, n)
      @pixels = default_color_pixels_for(m, n)
    end

    def clear
      @pixels.map! do |pixel|
        pixel.map! {DEFAULT_COLOR}
      end
    end

    def colourize(x, y, colour)
      @pixels[y.pred][x.pred] = colour
    end

    def draw_vertical(x, y1, y2, colour)
      (y1..y2).each do |y|
        colourize(x, y, colour)
      end
    end

    def draw_horizontal(x1, x2, y, colour)
      (x1..x2).each do |x|
        colourize(x, y, colour)
      end
    end

    def fill_region(x, y, colour)
      target_colour = @pixels[y.pred][x.pred]
      flood_fill(x, y, target_colour, colour)
    end

    def to_s
      @pixels.map {|pixel| pixel.join(' ')}.join("\n")
    end

    private
    def default_color_pixels_for(m, n)
      [].tap {|pixels| n.times {pixels << Array.new(m, DEFAULT_COLOR)}}
    end

    def flood_fill(x, y, target_colour, replacement_colour)
      if within_bounds(x, y) && @pixels[y.pred][x.pred] == target_colour
        @pixels[y.pred][x.pred] = replacement_colour
        flood_fill(x, y.pred, target_colour, replacement_colour)
        flood_fill(x, y.next, target_colour, replacement_colour)
        flood_fill(x.pred, y, target_colour, replacement_colour)
        flood_fill(x.next, y, target_colour, replacement_colour)
      end
    end

    def within_bounds(x, y)
      x >= 1 && x <= @pixels.first.size &&
      y >= 1 && y <= @pixels.size
    end
  end
end
