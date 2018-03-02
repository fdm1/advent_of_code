import PuzzleBase.PuzzleRunner;

public class CodeAdventMain {
  public static void main(String[] args) {
    PuzzleRunner puzzleRunner = null;

    String startMessage = String.format("Running puzzle for %s Day %s with input file ", args[0], args[1]);

    if (args.length >= 3) {
      puzzleRunner = new PuzzleRunner(args[0], args[1], args[2]);
      startMessage += args[2];
    } else if (args.length == 2) {
      String inputFile = defaultInputPath(args[0], args[1]);
      puzzleRunner = new PuzzleRunner(args[0], args[1], inputFile);
      startMessage += inputFile;
    } else {
      System.out.println("Usage: java CodeAdventMain YYYY DD [input_file]");
      System.exit(1);
    }

    System.out.println(startMessage);
    puzzleRunner.run();
  }

  private static String defaultInputPath(String year, String day) {
    return String.format("inputs/%s/%s.txt", year, day);
  }

  public CodeAdventMain() {
    // NOOP
  }
}