# test-rover

# Brief explanation of the solution design

- Implemented with Ruby 3.1.2p20 and RSpec 3.12.
- Each rover will be controlled sequentially. For 2+ rovers, when controlling the current rover, we will need to pay attention to the previously operated rovers that are still present within the map. 
- Rotation the rover is always possible, but we will only move the rover forward (to the direction it is facing) if the new position is within the map boundaries and there is no rover located on new position. This is possible in the solution by tracking a rover instance (from a `Rover` class) within the `grid` from a map instance (from the `Map` class). 
- It wouldn't be convenient for the user to hardcode the input file name and the output file name. Thus, I've added support for command line arguments(more details on how to use them below).
- The implementation has an `O(n*m)` time complexity. With `n` being the number of rovers and `m` as the average number of commands between all rovers. Since the order of the commands matter, the code processes one command at a time.
- I've taken in consideration good coding practices(such as DRY and clean code) and the project files/folders organization.

# Important assumptions/information

1) Assuming the supplied grid parameters are '5 5'. The grid will be actually 6x6 because it will start at (0,0) and end at (5,5). Theoretically, these position are valid for the rover: (0,0), (5,0), (0,5), (5,5)
2) The current implementation assumes **the provided input file names and their contents will always be correct**.
3) The current implementation assumes a rover will never be placed in the same position as a rover already present within the grid. The current implementation also assumes that we want to avoid collisions between the new rover and the rovers already present within the grid.
4) The rover **will not** move with a 'M' command to a new position if:
    - The new position exceeds the map boundaries.
    - There is another rover in the new position.
5) The following commands are needed to **setup** the project:
```
bundle install
```
6) The current implementation supports **command line arguments**. The input text files need to placed in the `input_files` folder. The output text files will be generated in the `output_files` folder. It can be run like this:
```
ruby lib/test_rover.rb example_input.txt example_output.txt
```
The command will generate the output text file and it will also print the final coordinates and direction for all rovers:

![image](https://user-images.githubusercontent.com/11583245/198854279-aa46ebfc-a930-4864-afa1-e602e109458f.png)

![image](https://user-images.githubusercontent.com/11583245/198854286-cd3a8c45-f1c7-461b-8a8f-d4b453e412c8.png)
![image](https://user-images.githubusercontent.com/11583245/198854415-810bdbd8-9b7f-4375-8173-c98ada658265.png)

7) The **automated tests** can be executed with this command:
```
rspec
```
The automated tests will run `TestRover.main` for each test case and it will generate output text files. The automated tests are closer to being **integration tests** instead of **unit tests**. The tests will compare the contents between the actual and the expected output text files (they will have `_correct` in their file names):

![image](https://user-images.githubusercontent.com/11583245/198854502-1ef2402b-4e2c-4ec5-b205-8137b188d162.png)

# Problem
A squad of robotic rovers are to be landed by NASA on a plateau on Mars. This plateau, which is curiously rectangular, must be navigated by the rovers so that their on-board cameras can get a complete view of the surrounding terrain to send back to Earth.

A rover's position and location is represented by a combination of x and y co-ordinates and a letter representing one of the four cardinal compass points. The plateau is divided up into a grid to simplify navigation. An example position might be 0, 0, N, which means the rover is in the bottom left corner and facing North.

In order to control a rover, NASA sends a simple string of letters. The possible letters are 'L', 'R' and 'M'. 'L' and 'R' makes the rover spin 90 degrees left or right respectively, without moving from its current spot. 'M' means move forward one grid point, and maintain the same heading.

Assume that the square directly North from (x, y) is (x, y+1).

# Input
The first line of input is the upper-right coordinates of the plateau, the lower-left coordinates are assumed to be 0,0.

The rest of the input is information pertaining to the rovers that have been deployed. Each rover has two lines of input. The first line gives the rover's position, and the second line is a series of instructions telling the rover how to explore the plateau.

The position is made up of two integers and a letter separated by spaces, corresponding to the x and y co-ordinates and the rover's orientation.

Each rover will be finished sequentially, which means that the second rover won't start to move until the first one has finished moving.

# Output
The output for each rover should be its final co-ordinates and heading.

# Test Input
5 5

1 2 N

LMLMLMLMM

3 3 E

MMRMMRMRRM

# Expected Output
1 3 N

5 1 E
