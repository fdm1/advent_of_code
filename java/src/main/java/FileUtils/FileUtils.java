package FileUtils;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

public class FileUtils {
  public static String readTextFile(String fileName) {
    String content = "";
    try {
      content = new String(Files.readAllBytes(Paths.get(fileName)));
    } catch (IOException e) {
      System.out.println(String.format("File %s does not exist", fileName));
      System.exit(1);
    }

    return content;

  }

  public static List<String> readTextFileByLines(String fileName) throws IOException {
    List<String> lines = Files.readAllLines(Paths.get(fileName));
    return lines;
  }
}
