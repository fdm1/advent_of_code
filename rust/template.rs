extern crate rustvent;

fn main() {
    let input = rustvent::get_input().expect("Must provide valid input path");
    let part_1 = "foo";
    let part_2 = "bar";

    println!("part 1: {}", part_1);
    println!("part 2: {}", part_2);
}

#[cfg(test)]
mod test_2017day1 {
    use super::*;
    #[test]
    fn test_foo() {
        assert_eq!(true, true);
    }
}