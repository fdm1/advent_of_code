extern crate rustvent;


fn main() {
    let input = rustvent::get_input().expect("Must provide valid input path");
    let input_num  = rustvent::util::string_to_nums(&input.trim())[0];
    let part_1 = get_manhattan_distance(&input_num);
    let part_2 = "undefined";

    println!("part 1: manhattan_distance = {}", part_1);
    println!("part 2: {}", part_2);
}

fn ring_level(num: &u32) -> (u32, u32, u32){
    let mut max_value = 1;
    let mut level = 0;
    let mut side_len = 1;
    while &max_value < num {
        level = level + 1;
        side_len = (level * 2) + 1;
        max_value = side_len + side_len * (side_len - 1);
    }

    (side_len, level, max_value)
}


fn get_manhattan_distance(num: &u32) -> u32 {
    let (side_len, level, mut max_value) = ring_level(num);
    while &max_value > num { max_value = max_value - (side_len - 1); }

    // TODO: figure out abs or switch to signed? (or just leave alone)
    let lateral = match (max_value + (side_len/2)) > *num {
        true => (max_value + (side_len/2)) - num,
        false => num - (max_value + (side_len/2)),
    };
    return lateral + level

}

#[cfg(test)]
mod test_2017day3 {
    use super::*;

    #[test]
    fn test_ring_level_returns_bounds_of_a_numbers_ring() {
        let num = 4;
        assert_eq!(ring_level(&num), (3, 1, 9));
        let num = 10;
        assert_eq!(ring_level(&num), (5, 2, 25));
        let num = 50;
        assert_eq!(ring_level(&num), (9, 4, 81));
    }
    #[test]
    fn test_get_manhattan_distance_returns_number_of_moves_to_the_center() {
        let num = 4;
        assert_eq!(get_manhattan_distance(&num), 1);
        let num = 10;
        assert_eq!(get_manhattan_distance(&num), 3);
        let num = 50;
        assert_eq!(get_manhattan_distance(&num), 7);
    }
}
