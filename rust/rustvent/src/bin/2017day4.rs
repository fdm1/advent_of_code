extern crate rustvent;


fn main() {
    let input = rustvent::get_input().expect("Must provide valid input path");
    let part_1 = count_unique_word_passphrases(&input, contains_no_duplicates);
    let part_2 = count_unique_word_passphrases(&input, contains_no_duplicate_anagrams);

    println!("part 1: count_unique_word_passphrase: {}", part_1);
    println!("part 2: count_unique_anagram_passphrases: {}", part_2);
}

fn count_unique_word_passphrases(text: &str, duplicate_checker: fn(Vec<&str>) -> bool) -> u32 {
  text.lines().map(|phrase| {
      match duplicate_checker(rustvent::util::string_to_words(&phrase)) {
          true => 1,
          false => 0,
      }
  }).sum()
}

fn contains_no_duplicates(word_vec: Vec<&str>) -> bool {
    let mut new_vec: Vec<&str> = vec![];
    let orig_size = word_vec.len();
    for word in word_vec {
        if new_vec.contains(&word) { return false }
        new_vec.push(&word)
    }

    new_vec.len() == orig_size
}

fn contains_no_duplicate_anagrams(word_vec: Vec<&str>) -> bool {
    let mut new_vec: Vec<Vec<char>> = vec![];
    let orig_size = word_vec.len();
    for word in word_vec.into_iter().map(|word| {
        let mut char_vec: Vec<char>= word.chars().collect();
        char_vec.sort_by(|a, b| b.cmp(a));

        char_vec
    }) {
        if new_vec.contains(&word) { return false }
        new_vec.push(word)
    }
    new_vec.len() == orig_size
}

#[cfg(test)]
mod test_2017day4 {
    use super::*;

    #[test]
    fn test_contains_no_duplicates_returns_true_if_all_strs_in_a_vec_are_unique() {
        assert_eq!(contains_no_duplicates(vec!("foo", "bar")), true);
        assert_eq!(contains_no_duplicates(vec!("foo", "bar", "fooo")), true);
        assert_eq!(contains_no_duplicates(vec!("foo", "bar", "bar")), false);
        assert_eq!(contains_no_duplicates(vec!("aa", "bb", "cc", "dd", "aa")), false);
        assert_eq!(contains_no_duplicates(vec!("aa", "bb", "cc", "dd", "aaa")), true);
    }


    #[test]
    fn test_contains_no_duplicate_anagrams_returns_true_if_all_strs_in_a_vec_are_unique_anagrams() {
        assert_eq!(contains_no_duplicate_anagrams(vec!("foo", "bar")), true);
        assert_eq!(contains_no_duplicate_anagrams(vec!("foo", "bar", "fooo")), true);
        assert_eq!(contains_no_duplicate_anagrams(vec!("foo", "bar", "bar")), false);
        assert_eq!(contains_no_duplicate_anagrams(vec!("foo", "rab", "bar")), false);
        assert_eq!(contains_no_duplicate_anagrams(vec!("aa", "bb", "cc", "dd", "aa")), false);
        assert_eq!(contains_no_duplicate_anagrams(vec!("aa", "bb", "cc", "dd", "aaa")), true);
        assert_eq!(contains_no_duplicate_anagrams(vec!("abcde", "xyz", "ecdab")), false);
        assert_eq!(contains_no_duplicate_anagrams(vec!("a", "ab", "abc", "abd", "abf", "abj")), true);
    }
    #[test]
    fn test_count_unique_word_passphrases_counts_only_phrases_with_unique_words() {
        assert_eq!(count_unique_word_passphrases("aa bb cc dd ee\naa bb cc dd aa\naa bb cc dd aaa\n", contains_no_duplicates), 2);
        assert_eq!(count_unique_word_passphrases("aa bb cc dd ee\naa bb cc dd ab\naa bb cc dd aaa\n", contains_no_duplicates), 3);
    }
    #[test]
    fn test_count_unique_word_passphrases_counts_only_phrases_with_unique_anagrams() {
        assert_eq!(count_unique_word_passphrases("foo bar\nfoo bar\nfoo bar", contains_no_duplicate_anagrams), 3);
        assert_eq!(count_unique_word_passphrases("foo bar\nfoo bar\nfoo bar rab", contains_no_duplicate_anagrams), 2);
    }
}
