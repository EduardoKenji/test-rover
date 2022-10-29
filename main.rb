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
  # Map(x, y, width, height)
  Map.new(0, 0, map_width, map_height)
end

def create_rover(rover_info)
  rover_x = rover_info[0].to_i
  rover_y = rover_info[1].to_i
  rover_dir = rover_info[2]
  Rover.new(rover_x, rover_y, rover_dir)
end

def main
  file_data = get_file_data('input.txt')
  map_info = file_data[0].split
  map = create_map(map_info)
  (1..file_data.length - 2).step(2) do |i|
    rover_info = file_data[i].split
    rover = create_rover(rover_info)
    rover_commands = file_data[i + 1].chars
  end
end

main if __FILE__ == $PROGRAM_NAME
