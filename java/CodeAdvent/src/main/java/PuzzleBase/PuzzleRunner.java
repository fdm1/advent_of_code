package PuzzleBase;

import java.util.HashMap;

import FileUtils.FileUtils;
import Year2015.Day1;

public class PuzzleRunner {
  private String year;
  private String day;
  private String inputFile;
  private Puzzle puzzleClass;

  private static final HashMap<String, Puzzle> puzzleMap;
  static
  {
    puzzleMap = new HashMap<>();
    puzzleMap.put("201501", new Day1());
  }

  private void printStartMessage() {
    System.out.println(String.format("Running puzzle for %s Day %s with input file %s", year, day, inputFile));
  }

  public PuzzleRunner(String year, String day, String inputFile) {
    this.year = year;
    this.day = day;
    this.inputFile = inputFile;
    setPuzzleClass(year, day);
  }

  public PuzzleRunner(String year, String day) {
    this.year = year;
    this.day = day;
    this.inputFile = defaultInputPath();
    setPuzzleClass(year, day);
  }

  public void run() {
    if (puzzleClass == null) {
      printStartMessage();
      System.out.println(String.format("No puzzle exists for %s-%s", year, day));
      System.exit(1);
    }

    String input = FileUtils.readTextFile(inputFile);
    puzzleClass.runPart1(input);
    puzzleClass.runPart2(input);
  }

  private void setPuzzleClass(String year, String day) {
    this.puzzleClass = puzzleMap.get(year + day);
  }

  private String defaultInputPath() {
    return String.format("src/main/resources/inputs/%s/%s.txt", year, day);
  }

}

