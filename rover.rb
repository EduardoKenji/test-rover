# NASA rover abstraction
class Rover
  def initialize(current_x, current_y, direction)
    @current_x = current_x
    @current_y = current_y
    @direction = direction
  end

  attr_accessor :current_x, :current_y, :direction
end
