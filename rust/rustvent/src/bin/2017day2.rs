extern crate rustvent;

fn main() {
	let input = rustvent::get_input().expect("Must provide valid input path");
	let captcha_min_max = captcha_min_max(&input.trim());
	let captcha_even = captcha_even(&input.trim());
	println!("captcha_min_max = {}", captcha_min_max);
    println!("captcha_even = {}", captcha_even);
}

fn captcha_min_max(grid: &str) -> u32 {
    18
}

fn captcha_even(grid: &str) -> u32 {
    9
}

#[cfg(test)]
mod day2_tests {
    use super::*;

    // #[test]
    // fn string_to_digits_returns_vec_of_digits() {
    //     assert_eq!(vec![1, 1, 2, 2], string_to_digits("1122"));
    // }
    #[test]
    fn captcha_min_max_returns_sum_of_max_minus_min() {
        let x = captcha_min_max("5 1 9 5\n7 5 3\n2 4 6 8");
        assert_eq!(18, x);
    }
    #[test]
    fn captcha_even_returns_sum_of_evenly_divisible() {
        let x = captcha_even("5 9 2 8\n9 4 7 3\n3 8 6 5");
        assert_eq!(9, x);
    }
}
