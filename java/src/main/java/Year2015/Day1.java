package Year2015;


import PuzzleBase.Puzzle;

public class Day1 implements Puzzle {

  public void runPart1(String input) {
    Integer res = processInput(input, false);
    System.out.println("Santa is on floor " + res);
  }

  public void runPart2(String input) {
    Integer res = processInput(input, true);
    System.out.println("Santa found the basement in " + res + " steps");
  }

  public Integer processInput(String input, boolean stopInBasement) {
    int currentFloor = 0;
    int step = 0;

    for (String chr : input.split("")) {
      step += 1;
      if (chr.equals("(")) {
        currentFloor += 1;
      } else {
        currentFloor -= 1;
      }
      if (stopInBasement && currentFloor < 0) {
        return step;
      }
    }

    return currentFloor;
  }
}
