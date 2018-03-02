package PuzzleBase;

import java.util.HashMap;

import Year2015.Day1;

public class PuzzleRunner {
  private String year;
  private String day;
  private String inputPath;
  private Puzzle puzzleClass;

  private static final HashMap<String, Puzzle> puzzleMap;
  static
  {
    puzzleMap = new HashMap<String, Puzzle>();
    puzzleMap.put("201501", new Day1());
  }

  public PuzzleRunner(String year, String day, String inputFile) {
    this.year = year;
    this.day = day;
    this.inputPath = inputFile;
    setPuzzleClass(year, day);
  }

  public void run() {
    if (puzzleClass == null) {
      System.out.println(String.format("No puzzle exists for %s-%s", year, day));
      System.exit(1);
    }

    puzzleClass.run(inputPath);
  }

  private void setPuzzleClass(String year, String day) {
    this.puzzleClass = puzzleMap.get(year + day);
  }
}

