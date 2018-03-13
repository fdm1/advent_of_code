import PuzzleBase.PuzzleRunner;

public class CodeAdventMain {
  public static void main(String[] args) {
    PuzzleRunner puzzleRunner = null;

    if (args.length >= 3) {
      puzzleRunner = new PuzzleRunner(args[0], args[1], args[2]);
    } else if (args.length == 2) {
      puzzleRunner = new PuzzleRunner(args[0], args[1]);
    } else {
      System.out.println("Usage: java CodeAdventMain YYYY DD [input_file]");
      System.exit(1);
    }

    puzzleRunner.run();
  }
  public CodeAdventMain() {
    // NOOP
  }
}