### Running Puzzles:

`./scripts/run.sh 2017day1`

Or `./scripts/shell.sh`, and then `cargo run --bin 2017day1 input/2017day1.txt`

### Running Tests:

`./scripts/test.sh` OR `./scripts/shell.sh` and `cargo test`

### Building Puzzle Solutions:

Template bin file contents for a given day (e.g., `src/bin/2017day1.rs`):

```
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
```

### Storing Puzzle Inputs:

Place input in `inputs` as `YYYYdayX.txt` (e.g. `inputs/2017day1.txt`)
