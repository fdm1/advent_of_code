package Year2015;


import PuzzleBase.Puzzle;

import static java.lang.Boolean.FALSE;
import static java.lang.Boolean.TRUE;


public class Day1 implements Puzzle {

  public void runPart1(String input) {
    Integer res = processInput(input, FALSE);
    System.out.println("Santa found the basement in " + res + " steps");
  }

  public void runPart2(String input) {
    Integer res = processInput(input, TRUE);
    System.out.println("Santa is on floor " + res);
  }

  public Integer processInput(String input, Boolean stopInBasement) {
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
