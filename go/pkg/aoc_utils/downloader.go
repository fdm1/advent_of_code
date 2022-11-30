package aoc_utils

import (
  "fmt"
  "io/ioutil"
  "net/http"
  "os"
  "github.com/joho/godotenv"
)

func DownloadInput(year int, day int, cache bool) string {
  cacheFilename := fmt.Sprintf("downloads/%v-%d.txt", year, day)
  if cache {
    content, err := os.ReadFile(cacheFilename)

    if err != nil {
      fmt.Fprintf(os.Stderr, "Unable to read input for %v-%v. Downloading from AoC ...\n", year, day)
    } else {
      return string(content)
    }
  }
  err := godotenv.Load()

  url := fmt.Sprintf("https://adventofcode.com/%v/day/%v/input", year, day)
  cookie := os.Getenv("AOC_SESSION")
	c := &http.Cookie{
		Name:  "session",
		Value: cookie,
	}

	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error creating request: %s\n", err)
		os.Exit(4)
	}
	req.AddCookie(c)

  client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error retrieving input: %s\n", err)
		os.Exit(2)
	}
	defer resp.Body.Close()

  body, err := ioutil.ReadAll(resp.Body)

	if err != nil {
		fmt.Fprintf(os.Stderr, "Error reading input body: %s\n", err)
		os.Exit(3)
	}

  if cache {
    err := os.WriteFile(cacheFilename, body, 0644)
    if err != nil {
      fmt.Fprintf(os.Stderr, "Error caching input: %s\n", err)
      os.Exit(3)
    }
  }

  return string(body)
}
