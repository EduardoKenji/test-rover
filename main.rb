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

def main
  file_data = get_file_data('input.txt')
  map_info = file_data[0].split
  map = create_map(map_info)
end

main if __FILE__ == $PROGRAM_NAME
