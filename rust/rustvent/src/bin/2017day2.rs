extern crate rustvent;

fn main() {
	let input = rustvent::get_input().expect("Must provide valid input path");
	let checksum_min_max = checksum_min_max(&input.trim());
	let checksum_even = checksum_even(&input.trim());
	println!("part 1: checksum_min_max = {:?}", checksum_min_max);
    println!("part 2: checksum_even = {}", checksum_even);
}

fn checksum_min_max(grid: &str) -> u32 {
    grid.lines().map(|row| {
        let mut digits = rustvent::util::string_to_u32_vec(&row);
        digits.sort();
        let min = digits.first().unwrap();
        let max = digits.last().unwrap();
        max - min
    }).sum()
}

fn checksum_even(grid: &str) -> u32 {
    grid.lines().map(|row| {
        let mut num: u32 = 0;
        let mut denom: u32 = 0;
        let digits = rustvent::util::string_to_u32_vec(&row);
        for i in &digits {
            for k in &digits {
                if is_divisible(i, k) {
                    num = *i;
                    denom = *k;
                }
            }
        }
        num / denom
    }).sum()
}

fn is_divisible(num: &u32, denom: &u32) -> bool {
    num > denom && num % denom == 0
}

#[cfg(test)]
mod test_2017day2 {
    use super::*;

    #[test]
    fn test_is_divisible_returns_bool_if_divisible() {
        let (x, y) = (5, 3);
        let res = is_divisible(&x,&y);
        assert_eq!(false, res);
        let (x, y) = (12, 6);
        let res = is_divisible(&x,&y);
        assert_eq!(true, res);
    }
    #[test]
    fn test_checksum_min_max_returns_sum_of_max_minus_min() {
        let x = checksum_min_max("5 1 9 5\n7 5 3\n2 4 6 8");
        assert_eq!(18, x);
    }
    #[test]
    fn test_checksum_even_returns_sum_of_evenly_divisible() {
        let x = checksum_even("5 9 2 8\n9 4 7 3\n3 8 6 5");
        assert_eq!(9, x);
    }
}
