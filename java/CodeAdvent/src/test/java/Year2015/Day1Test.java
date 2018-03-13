package Year2015;

import java.util.HashMap;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;


class Day1Test {
  private Day1 runner;

  @BeforeEach
  void setUpStreams() {
    runner = new Day1();
  }

  @Test
  void test2015Day1ProcessInputFindsFinalFloor() {
    HashMap<String, Integer> testInput;
    testInput = new HashMap<>();
    testInput.put("(())", 0);
    testInput.put("))(((((", 3);
    testInput.put(")())())", -3);

    for (String input : testInput.keySet()) {
      assertEquals(testInput.get(input), runner.processInput(input, false));
    }
  }

  @Test
  void test2015Day1ProcessInputFindsWhenBasementIsReached() {
    HashMap<String, Integer> testInput;
    testInput = new HashMap<>();
    testInput.put(")", 1);
    testInput.put("()())", 5);

    for (String input : testInput.keySet()) {
      assertEquals(testInput.get(input), runner.processInput(input, true));
    }
  }
}