require_relative 'map'
require_relative 'rover'

module TestRover
  # Get the file from the 'input_files' or 'output_files' folder
  def self.get_file(file_type_folder, file_name, file_flag)
    parent_directory = File.expand_path('..', __dir__)
    files_directory = File.join(parent_directory, file_type_folder)
    file_path = File.join(files_directory, file_name)
    File.open(file_path, file_flag)
  end

  # Return input file data as an array of lines
  def self.get_input_file_data(file_name)
    file = get_file('input_files', file_name, 'r')
    file_data = file.readlines.map(&:chomp)
    file.close
    file_data
  end

  # Return output file to write the results
  def self.get_output_file(file_name)
    get_file('output_files', file_name, 'w')
  end

  def self.create_map(map_info)
    map_width = map_info[0].to_i
    map_height = map_info[1].to_i
    Map.new(map_width, map_height)
  end

  def self.create_rover(rover_info)
    rover_x = rover_info[0].to_i
    rover_y = rover_info[1].to_i
    rover_dir = rover_info[2]
    Rover.new(rover_x, rover_y, rover_dir)
  end

  # The function will check for some conditions before actually moving the drone. We need to update both drone and map
  # Important: I am assuming the presence of multiple rovers could lead to collisions if unchecked.
  # Therefore, we won't move the rover if there is another rover in the position we want to move our current rover
  def self.attempt_to_move_rover(rover, map, new_x, new_y)
    are_coordinates_valid = new_x >= 0 && new_x <= map.width && new_y <= map.height && new_y >= 0
    return unless are_coordinates_valid && map.grid_position_empty?(new_x, new_y)

    map.update_rover_position_inside_map(rover, new_x, new_y)
    rover.move_to_new_position(new_x, new_y)
  end

  def self.move_rover(rover, map)
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

  # Process all commands for a specific rover
  def self.control_rover(rover, map, rover_commands)
    rover_commands.each do |command|
      if command == 'M'
        move_rover(rover, map)
      elsif %w[L R].include?(command)
        rover.rotate(command)
      end
    end
  end

  def self.get_rover_state(rover)
    "#{rover.current_x} #{rover.current_y} #{rover.direction}\n"
  end

  # Process all rovers and their commands sequentially
  def self.process_rovers(map, file_data, output_file_name)
    output_file = get_output_file(output_file_name)
    (1..file_data.length - 2).step(2) do |i|
      rover_info = file_data[i].split
      rover = create_rover(rover_info)
      map.add_rover_to_map(rover)
      rover_commands = file_data[i + 1].chars
      control_rover(rover, map, rover_commands)
      puts get_rover_state(rover)
      output_file.write(get_rover_state(rover))
    end
    output_file.close
  end

  def self.main(input_file_name, output_file_name)
    file_data = get_input_file_data(input_file_name)
    map_info = file_data[0].split
    map = create_map(map_info)
    process_rovers(map, file_data, output_file_name)
  end
end

Main.main(ARGV[0], ARGV[1]) if __FILE__ == $PROGRAM_NAME
