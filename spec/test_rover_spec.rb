require 'test_rover'

describe TestRover do
  describe 'control rovers sequentially' do
    context "given 'example_input.txt'" do
      it "writes 'example_output.txt'" do
        expect(test_control_rovers('example_input.txt', 'example_output.txt',
                                   'example_output_correct.txt')).to be_truthy
      end
    end

    context "given 'simple_input.txt'" do
      it "writes 'simple_output.txt'" do
        expect(test_control_rovers('simple_input.txt', 'simple_output.txt',
                                   'simple_output_correct.txt')).to be_truthy
      end
    end

    context "given 'map_corner_input.txt'" do
      it "writes 'map_corner_output.txt'" do
        expect(test_control_rovers('map_corner_input.txt', 'map_corner_output.txt',
                                   'map_corner_output_correct.txt')).to be_truthy
      end
    end

    context "given 'edge_case_input.txt'" do
      it "writes 'edge_case_output.txt'" do
        expect(test_control_rovers('edge_case_input.txt', 'edge_case_output.txt',
                                   'edge_case_output_correct.txt')).to be_truthy
      end
    end

    context "given 'collisions_input.txt'" do
      it "writes 'collisions_output.txt'" do
        expect(test_control_rovers('collisions_input.txt', 'collisions_output.txt',
                                   'collisions_output_correct.txt')).to be_truthy
      end
    end
  end
end

private

# Test control rovers, generate output file and compare the expected and actual output files
def test_control_rovers(input_file_name, output_file_name, correct_output_file_name)
  TestRover.main(input_file_name, output_file_name)
  compare_files(output_file_name, correct_output_file_name)
end

# Compare if both files content are the same
def compare_files(first_file_name, second_file_name)
  first_file = get_file('output_files', first_file_name, 'r')
  second_file = get_file('output_files', second_file_name, 'r')
  first_file_lines = first_file.readlines.map(&:chomp)
  second_file_lines = second_file.readlines.map(&:chomp)
  return false if first_file_lines.length != second_file_lines.length

  first_file_lines.each_with_index do |line, i|
    return false if line != second_file_lines[i]
  end
  true
end

def get_file(file_type_folder, file_name, file_flag)
  parent_directory = File.expand_path('..', __dir__)
  files_directory = File.join(parent_directory, file_type_folder)
  file_path = File.join(files_directory, file_name)
  File.open(file_path, file_flag)
end
