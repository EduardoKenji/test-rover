require './map'
require './rover'

# Return file data as an array of lines
def get_file_data(file_name)
  file_path = File.join(__dir__, file_name)
  file = File.open(file_path, 'r+')
  file.readlines.map(&:chomp)
end

def create_map(map_info)
  map_width = map_info[0].to_i
  map_height = map_info[1].to_i
  Map.new(map_width, map_height)
end

def create_rover(rover_info)
  rover_x = rover_info[0].to_i
  rover_y = rover_info[1].to_i
  rover_dir = rover_info[2]
  Rover.new(rover_x, rover_y, rover_dir)
end

# The function will check for some conditions before actually moving the drone. We need to update both drone and map
# Important: I am assuming the presence of multiple rovers could lead to collisions if unchecked.
# Therefore, we won't move the rover if there is another rover in the position we want to move our current rover
def attempt_to_move_rover(rover, map, new_x, new_y)
  are_coordinates_valid = new_x >= 0 && new_x <= map.width && new_y <= map.height && new_y >= 0
  if map.grid_position_empty?(new_x, new_y) && are_coordinates_valid
    map.update_rover_position_inside_map(rover, new_x, new_y)
    rover.move_to_new_position(new_x, new_y)
  end
end

def move_rover(rover, map)
  case rover.direction
  when 'N'
    attempt_to_move_rover(rover, map, rover.current_x, rover.current_y + 1)
  when 'W'
    attempt_to_move_rover(rover, map, rover.current_x - 1, rover.current_y)
  when 'S'
    attempt_to_move_rover(rover, map, rover.current_x, rover.current_y - 1)
  when 'E'
    attempt_to_move_rover(rover, map, rover.current_x + 1, rover.current_y)
  end
end

def control_rover(rover, map, rover_commands)
  rover_commands.each do |command|
    if command == 'M'
      move_rover(rover, map)
    else
      rover.rotate(command)
    end
  end
end

def get_current_rover_stats(rover)
  "#{rover.current_x} #{rover.current_y} #{rover.direction}"
end

def main
  file_data = get_file_data('input.txt')
  map_info = file_data[0].split
  map = create_map(map_info)
  (1..file_data.length - 2).step(2) do |i|
    rover_info = file_data[i].split
    rover = create_rover(rover_info)
    map.add_rover_to_map(rover)
    rover_commands = file_data[i + 1].chars
    control_rover(rover, map, rover_commands)
    puts get_current_rover_stats(rover)
  end
end

main if __FILE__ == $PROGRAM_NAME
