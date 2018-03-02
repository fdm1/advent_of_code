package PuzzleBase;

import java.util.HashMap;

import FileUtils.FileUtils;
import Year2015.Day1;

public class PuzzleRunner {
  private String year;
  private String day;
  private String input;
  private Puzzle puzzleClass;

  private static final HashMap<String, Puzzle> puzzleMap;
  static
  {
    puzzleMap = new HashMap<>();
    puzzleMap.put("201501", new Day1());
  }

  public PuzzleRunner(String year, String day, String inputFile) {
    this.year = year;
    this.day = day;
    this.input = FileUtils.readTextFile(inputFile);
    setPuzzleClass(year, day);
  }

  public void run() {
    if (puzzleClass == null) {
      System.out.println(String.format("No puzzle exists for %s-%s", year, day));
      System.exit(1);
    }

    puzzleClass.runPart1(input);
    puzzleClass.runPart2(input);
  }

  private void setPuzzleClass(String year, String day) {
    this.puzzleClass = puzzleMap.get(year + day);
  }
}

