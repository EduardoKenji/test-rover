# NASA rover abstraction
class Rover
  def initialize(current_x, current_y, direction)
    @current_x = current_x
    @current_y = current_y
    @direction = direction
  end

  attr_accessor :current_x, :current_y, :direction

  def rotate(command)
    turn_to_direction_map = { 'N' => { 'L' => 'W', 'R' => 'E' },
                              'W' => { 'L' => 'S', 'R' => 'N' },
                              'S' => { 'L' => 'E', 'R' => 'W' },
                              'E' => { 'L' => 'N', 'R' => 'S' } }
    @direction = turn_to_direction_map[@direction][command]
  end

  def move_to_new_position(new_x, new_y)
    @current_x = new_x
    @current_y = new_y
  end
end
