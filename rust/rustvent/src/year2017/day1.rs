use std::str;

pub fn main(part: String, input: String) {
	let captcha = captcha(&input.trim());
	let captcha_half = captcha_half(&input.trim());
	if *&part.eq("1") { println!("captcha = {}", captcha); }
	else {println!("captcha = {}", captcha_half);}
}

fn string_to_digits(row: &str) -> Vec<u32> {
    row.chars().map(|c| c.to_digit(10).unwrap()).collect()
}


fn captcha(row_str: &str) -> u32 {
	let digits = string_to_digits(&row_str);
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
	let digits = string_to_digits(&row_str);
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
mod day1_tests {
    use super::*;

    #[test]
    fn string_to_digits_returns_vec_of_digits() {
        assert_eq!(vec![1, 1, 2, 2], string_to_digits("1122"));
    }
    #[test]
    fn part1() {
        let x = captcha("1122");
        assert_eq!(3, x);
        let x = captcha("1111");
        assert_eq!(4, x);
        let x = captcha("1234");
        assert_eq!(0, x);
        let x = captcha("91212129");
        assert_eq!(9, x);
    }
    #[test]
    fn part2() {
        let x = captcha_half("1122");
        assert_eq!(0, x);
        let x = captcha_half("1111");
        assert_eq!(4, x);
        let x = captcha_half("1212");
        assert_eq!(6, x);
        let x = captcha_half("12131415");
        assert_eq!(4, x);
    }
}
