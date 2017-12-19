extern crate rustvent;


fn main() {
    let input = rustvent::get_input().expect("Must provide valid input path");
    let part_1 = steps_to_exit(&input, always_increase_offset);
    let part_2 = steps_to_exit(&input, decrease_gte_three);

    println!("part 1: steps_to_exit - always increase: {}", part_1);
    println!("part 2: steps_to_exit - decrease gte three: {}", part_2);
}


fn always_increase_offset(_offset: i32) -> bool {
    return true
}

fn decrease_gte_three(_offset: i32) -> bool {
    _offset < 3
}


fn steps_to_exit(input: &str, offset_increases: fn(offset: i32) -> bool) -> i32 {
    let mut position = 0;
    let mut step: i32 = 0;
    let mut instructions: Vec<i32> = rustvent::util::split_string_rows(&input)
        .into_iter()
        .map(|i| { i.parse().unwrap() })
        .collect();
    while position < instructions.len() {
        if offset_increases(instructions[position]) {
            instructions[position] = instructions[position] + 1;
            position = (position as i32 + instructions[position] - 1) as usize;
        }
        else {
            instructions[position] = instructions[position] - 1;
            position = (position as i32 + instructions[position] + 1) as usize;
        };
        step = step + 1;
    }
    step
}



#[cfg(test)]
mod test_2017day5 {
    use super::*;
    #[test]
    fn test_decrease_gte_three(){
        assert_eq!(true, decrease_gte_three(0));
        assert_eq!(true, decrease_gte_three(1));
        assert_eq!(true, decrease_gte_three(2));
        assert_eq!(false, decrease_gte_three(3));
        assert_eq!(false, decrease_gte_three(10));

    }

    #[test]
    fn test_steps_to_exit_returns_number_of_steps_to_exit_maze() {
        assert_eq!(5, steps_to_exit("0\n3\n0\n1\n-3", always_increase_offset));
        assert_eq!(3, steps_to_exit("0\n4\n0\n1\n-3", always_increase_offset));
        assert_eq!(10, steps_to_exit("0\n3\n0\n1\n-3", decrease_gte_three));
    }
}
