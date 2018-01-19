extern crate rustvent;

fn main() {
    let input = rustvent::get_input().expect("Must provide valid input path");
    let input_vec: Vec<u32> = input.split(",").map(|i| i.parse().unwrap()).collect();
    let part_1_hash = get_hash_vec(input_vec, initialize_num_vec(NUM_LENGTH), 0, 0).0;
    println!("part 1: first two product: {:?}", part_1_hash[0] * part_1_hash[1]);
    println!("part 2: string_hash: {}", string_hash(input));
}

const NUM_LENGTH: u32 = 256;

fn string_to_ascii(input: String) -> Vec<u8> { input.chars().map(|i| i as u8).collect() }

fn get_part2_lengths(input_string: String) -> Vec<u32> {
    let mut lengths = string_to_ascii(input_string);
    let mut suffix: Vec<u8> = vec!(17, 31, 73, 47, 23);
    lengths.append(&mut suffix);
    lengths.iter().map(|i| *i as u32).collect()
}


fn initialize_num_vec(num_steps: u32) -> Vec<u32> { (0..num_steps).collect() }

fn reverse_subvec(mut num_vec: Vec<u32>, start: usize, len: usize) -> Vec<u32> {
    let mut indices: Vec<usize> = (start..start+len)
        .map(|x| x % num_vec.len())
        .collect();

    while indices.len() > 1 {
        let first = *indices.first().unwrap();
        let last = *indices.last().unwrap();
        &num_vec.swap(first, last);
        indices.pop().unwrap();
        if indices.len() > 0 {indices.remove(0);};
    }

    num_vec
}

fn get_hash_vec(input_vec: Vec<u32>, mut num_vec: Vec<u32>,
    mut position: usize, mut step: usize) -> (Vec<u32>, usize, usize) {
    for i in input_vec {
        num_vec = reverse_subvec(num_vec, position, i as usize);
        position = (position + i as usize + step) % num_vec.len();
        step += 1 as usize;
    }

    (num_vec, position, step)
}

fn get_sparse_hash(input_vec: Vec<u32>, vec_size: u32) -> Vec<u32> {
    let mut num_vec = initialize_num_vec(vec_size);
    let mut round = 0;
    let mut position: usize = 0;
    let mut step: usize = 0;

    while round < 64 {
        let res = get_hash_vec(input_vec.clone(), num_vec, position, step);
        num_vec = res.0;
        position = res.1;
        step = res.2;
        round += 1;
    }

    num_vec
}

fn get_dense_hash(sparse_hash: Vec<u32>) -> Vec<u32> {
    let step_size: usize = 16;
    let mut sparse_hash_clone = sparse_hash.clone();
    let mut dense_hash: Vec<u32> = vec!();
    while sparse_hash_clone.len() >= step_size {
        let remainder = sparse_hash_clone.split_off(step_size);
        dense_hash.push(sparse_hash_clone.iter().fold(0u32, {|a, b| a ^ b}));
        sparse_hash_clone = remainder;
    };
    dense_hash
}

fn u32_vec_to_hexadecimal(dense_hash: Vec<u32>) -> String {
    dense_hash.iter().map(|i| {
        let hex = format!("{:x}", i);
        match hex.len() {
            2 => {hex},
            _ => format!("0{}", hex)
        }
    }).collect()
}

fn string_hash(input_string: String) -> String {
    let input_lengths = get_part2_lengths(input_string);
    let sparse_hash = get_sparse_hash(input_lengths, NUM_LENGTH);
    let dense_hash = get_dense_hash(sparse_hash);
    u32_vec_to_hexadecimal(dense_hash)
}

#[cfg(test)]
mod test_2017day10 {
    use super::*;
    #[test]
    fn test_reverse_subvec_returns_vec_with_partial_reversal() {
        assert_eq!(reverse_subvec(vec!(1, 2, 3, 4, 5), 0, 2), vec!(2, 1, 3, 4, 5));
        assert_eq!(reverse_subvec(vec!(1, 2, 3, 4, 5), 2, 1), vec!(1, 2, 3, 4, 5));
        assert_eq!(reverse_subvec(vec!(1, 2, 3, 4, 5), 2, 2), vec!(1, 2, 4, 3, 5));
        assert_eq!(reverse_subvec(vec!(1, 2, 3, 4, 5), 3, 4), vec!(5, 4, 3, 2, 1));
        assert_eq!(reverse_subvec(vec!(4, 3, 0, 1, 2), 4, 2), vec!(2, 3, 0, 1, 4));
    }

    #[test]
    fn test_get_hash_vec_returns_correct_hashed_vector() {
        assert_eq!(
            get_hash_vec(vec!(3, 4, 1, 5),
            initialize_num_vec(5), 0,0), (vec!(3, 4, 2, 1, 0), 4, 4));
    }

    #[test]
    fn test_get_sparse_hash_runs_vec_hash_for_64_runs() {
        assert_eq!(get_sparse_hash(vec!(3, 4, 1, 5), 5), (vec!(3, 4, 0, 1, 2)));
    }

    #[test]
    fn test_string_to_ascii_returns_vec_of_u8_from_string() {
        assert_eq!(string_to_ascii("1,2,3".to_string()), vec!(49,44,50,44,51));
    }

    #[test]
    fn test_get_part2_lengths_converts_input_to_ascii_and_appends_suffix_values() {
        assert_eq!(
            get_part2_lengths("1,2,3".to_string()),
            vec!(49, 44, 50, 44, 51, 17, 31, 73, 47, 23));
    }

    #[test]
    fn test_get_dense_hash_returns_xor_of_every_16_of_sparse_hash() {
        assert_eq!(
            get_dense_hash(vec!(65, 27, 9, 1, 4, 3, 40, 50, 91, 7, 6, 0, 2, 5, 68, 22)),
            vec!(64));
        assert_eq!(get_dense_hash(vec!(
            65, 27, 9, 1, 4, 3, 40, 50, 91, 7, 6, 0, 2, 5, 68, 22,
            65, 27, 9, 1, 4, 3, 40, 50, 91, 7, 6, 0, 2, 5, 68, 22
        )) , vec!(64, 64));
        assert_eq!(
            get_dense_hash(vec!(65, 27, 9, 1, 4, 3, 40, 50, 91, 7, 6, 0, 2, 5, 68, 22, 1)),
            vec!(64));
    }

    #[test]
    fn test_u32_vec_to_hexadecimal_works() {
        assert_eq!(u32_vec_to_hexadecimal(vec!(255)), "ff");
        assert_eq!(u32_vec_to_hexadecimal(vec!(255, 255)), "ffff");
        assert_eq!(u32_vec_to_hexadecimal(vec!(64, 7, 255)), "4007ff");
    }

    #[test]
    fn test_string_hash_gets_hexadecimal_dense_hash_based_on_input_string() {
        assert_eq!(string_hash("".to_string()), "a2582a3a0e66e6e86e3812dcb672a272");
        assert_eq!(string_hash("AoC 2017".to_string()), "33efeb34ea91902bb2f59c9920caa6cd");
        assert_eq!(string_hash("1,2,3".to_string()), "3efbe78a8d82f29979031a4aa0b16a9d");
        assert_eq!(string_hash("1,2,4".to_string()), "63960835bcdc130f0b66d7ff4f6a5a8e");
    }
}