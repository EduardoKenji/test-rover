# NASA rover abstraction
class Rover
  def initialize(current_x, current_y)
    @current_x = current_x
    @current_y = current_y
  end

  attr_accessor :current_x, :current_y
end
