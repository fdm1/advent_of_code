pub fn split_string_rows(grid: &str) -> Vec<&str> {
    grid.split("\n").collect()
}

pub fn string_to_digits(row: &str) -> Vec<u32> {
    row.chars().map(|c| c.to_digit(10).unwrap()).collect()
}

pub fn string_to_nums(row: &str) -> Vec<u32> {
    row.split_whitespace().map(|i| i.parse().unwrap()).collect()
}

pub fn string_to_words(row: &str) -> Vec<&str> {
    row.split_whitespace().map(|w| w).collect()
}

#[cfg(test)]
mod test_util {
    use super::*;

    #[test]
    fn test_split_string_rows_returns_vec_of_strings() {
        assert_eq!(
            vec!["1 2", "3 4", "5 6", "7 8"],
            split_string_rows("1 2\n3 4\n5 6\n7 8"));
    }
    #[test]
    fn test_string_to_digits_returns_vec_of_digits() {
        assert_eq!(vec![1, 1, 2, 2], string_to_digits("1122"));
    }
    #[test]
    fn test_string_to_nums_returns_vec_of_int32() {
        assert_eq!(vec![12, 23, 42, 2], string_to_nums("12 23 42 2"));
    }
    #[test]
    fn test_string_to_words_returns_vec_of_strings() {
        assert_eq!(vec!["foo", "bar", "baz"], string_to_words("foo bar baz"));
    }
}
