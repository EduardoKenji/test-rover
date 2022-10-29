require 'test_rover'

describe TestRover do
  describe 'control rovers sequentially' do
    context "given 'example_input.txt'" do
      it "writes 'example_output.txt'" do
        input_file_name = 'example_input.txt'
        output_file_name = 'example_output.txt'
        correct_output_file_name = 'example_output_correct.txt'
        TestRover.main(input_file_name, output_file_name)
        expect(compare_files(output_file_name, correct_output_file_name)).to be_truthy
      end
    end

    context "given 'simple_tests_input.txt'" do
      it "writes 'simple_tests_output.txt'" do
        input_file_name = 'simple_tests_input.txt'
        output_file_name = 'simple_tests_output.txt'
        correct_output_file_name = 'simple_tests_output_correct.txt'
        TestRover.main(input_file_name, output_file_name)
        expect(compare_files(output_file_name, correct_output_file_name)).to be_truthy
      end
    end

    context "given 'map_corner_tests_input.txt'" do
      it "writes 'map_corner_tests_output.txt'" do
        input_file_name = 'map_corner_tests_input.txt'
        output_file_name = 'map_corner_tests_output.txt'
        correct_output_file_name = 'map_corner_tests_output_correct.txt'
        TestRover.main(input_file_name, output_file_name)
        expect(compare_files(output_file_name, correct_output_file_name)).to be_truthy
      end
    end
  end
end

private

def get_file(file_type_folder, file_name, file_flag)
  parent_directory = File.expand_path('..', __dir__)
  files_directory = File.join(parent_directory, file_type_folder)
  file_path = File.join(files_directory, file_name)
  File.open(file_path, file_flag)
end

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
