require './rover'

# Map abstraction to represent the plateau on Mars
class Map
  def initialize(width, height)
    @width = width
    @height = height
    @grid = Array.new(height + 1) { Array.new(width + 1, nil) }
  end

  attr_reader :width, :height, :grid

  def add_rover_to_map(rover)
    @grid[rover.current_y][rover.current_x] = rover
  end

  def update_rover_position_inside_map(rover, new_x, new_y)
    @grid[rover.current_y][rover.current_x] = nil
    @grid[new_y][new_x] = rover
  end

  def grid_position_empty?(new_x, new_y)
    @grid[new_y][new_x].nil?
  end
end
