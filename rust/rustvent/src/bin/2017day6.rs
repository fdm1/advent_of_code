extern crate rustvent;

fn main() {
    let input = rustvent::get_input().expect("Must provide valid input path");
    let part_1 = detect_infinite_loop(rustvent::util::string_to_u32_vec(&input));
    let part_2 = detect_infinite_loop(part_1.1);

    println!("part 1: detect_infinite_loop: {}", part_1.0);
    println!("part 2: detect_infinite_loop full cycle: {}", part_2.0);
}


fn detect_infinite_loop(mut input_vec: Vec<u32>) -> (u32, Vec<u32>) {
    let vec_len = input_vec.len() as u32;
    let mut step = 0;
    let mut past_results: Vec<Vec<u32>> = vec!();
    while !&past_results.contains(&input_vec) {
        step = step + 1;
        past_results.push(input_vec.clone());

        let mut max_index = get_vec_max_index(&input_vec) as usize;
        let mut max_val: u32 = input_vec[max_index];
        input_vec[max_index] = 0;
        while max_val  > 0  {
            max_index = ((max_index as u32 + 1) % vec_len) as usize;
            input_vec[max_index] = input_vec[max_index] + 1;
            max_val = max_val - 1;
        }
    }
    (step, input_vec)
}

fn get_vec_max_index(u32_vec: &Vec<u32>) -> u32 {
    let max_val = u32_vec.iter().cloned().fold(0, u32::max);
    u32_vec.into_iter()
        .position(|val | val == &max_val)
        .map(|i| i as u32)
        .unwrap()
}


#[cfg(test)]
mod test_2017day6 {
    use super::*;
    #[test]
    fn test_vec_max_index_returns_the_index_of_a_u32_vecs_max_value() {
        assert_eq!(0, get_vec_max_index(&vec![10, 3, 1, 10]));
        assert_eq!(1, get_vec_max_index(&vec![3, 10, 3, 1, 10]));
        assert_eq!(2, get_vec_max_index(&vec![10, 3, 15, 10]));
    }
    #[test]
    fn test_detect_infinite_loop_returns_the_step_when_an_infinite_loop_begins() {
        assert_eq!((5, vec![2, 4, 1, 2]), detect_infinite_loop(vec![0, 2, 7, 0]));
    }
}
