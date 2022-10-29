# Map abstraction to represent the plateau on Mars
class Map
  def initialize(starting_x, starting_y, width, height)
    @starting_x = starting_x
    @starting_y = starting_y
    @width = width
    @height = height
  end

  attr_reader :starting_x, :starting_y, :width, :height
end
