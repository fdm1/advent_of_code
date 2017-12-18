extern crate rustvent;

fn main() {
	let input = rustvent::get_input().expect("Must provide valid input path");
	let captcha_neighbors = captcha_neighbors(&input.trim());
	let captcha_half = captcha_half(&input.trim());
	println!("part 1: captcha_neighbors = {}", captcha_neighbors);
	println!("part 2: captcha_half = {}", captcha_half);
}

fn captcha_neighbors(row_str: &str) -> u32 {
	let digits = rustvent::util::string_to_digits(&row_str);
	let length = digits.len();

    digits
        .iter()
        .enumerate()
        .fold(0, |total, (i, &n)| {
            match digits[(i + 1) % length] == n
            {
                true => total + n,
                false => total,
            }
        })
}

fn captcha_half(row_str: &str) -> u32 {
	let digits = rustvent::util::string_to_digits(&row_str);
	let length = digits.len();
	let half = length / 2;

    digits
        .iter()
        .enumerate()
        .fold(0, |total, (i, &n)| {
            match digits[(i + half) % length] == n
            {
                true => total + n,
                false => total,
            }
        })
}

#[cfg(test)]
mod test_2017day1 {
    use super::*;

    # [test]
    fn test_capthcha_neighbors_returns_sum_of_matching_neighbors() {
        let x = captcha_neighbors("1122");
        assert_eq ! (3, x);
        let x = captcha_neighbors("1111");
        assert_eq !(4, x);
        let x = captcha_neighbors("1234");
        assert_eq ! (0, x);
        let x = captcha_neighbors("91212129");
        assert_eq ! (9, x);
    }

    # [test]
    fn test_captcha_half_returns_sum_of_matches_halfway_around() {
        let x = captcha_half("1122");
        assert_eq ! (0, x);
        let x = captcha_half("1111");
        assert_eq !(4, x);
        let x = captcha_half("1212");
        assert_eq ! (6, x);
        let x = captcha_half("12131415");
        assert_eq ! (4, x);
    }
}
