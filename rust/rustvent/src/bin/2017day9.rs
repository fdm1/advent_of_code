extern crate rustvent;

fn main() {
    let input = rustvent::get_input().expect("Must provide valid input path");
    let res = score_input(&input);
    println!("part 1: raw input score: {}", res.0);
    println!("part 2: garbage_count: {}", res.1);
}

fn score_input(input: &str) -> (u32, u32) {
    let mut in_garbage = false;
    let mut ignore_next = false;
    let mut score = 0;
    let mut garbage_count = 0;
    let mut group = 0;

    for i in input.chars() {
        if !ignore_next {
            match i {
                '<' => {
                    if in_garbage { garbage_count += 1; };
                    in_garbage = true;
                },
                '>' => { in_garbage = false; },
                '{' => { if !in_garbage { group += 1; } else { garbage_count += 1; }; },
                '}' => {
                    if !in_garbage {
                        score += group;
                        group -= 1;
                    } else { garbage_count += 1; };
                },
                '!' => { ignore_next = true; },
                _ => { if in_garbage { garbage_count += 1; } },
            }
        } else { ignore_next = false; }
    }

    (score, garbage_count)
}



#[cfg(test)]
mod test_2017day9 {
    use super::*;
    #[test]
    fn test_score_text_returns_correct_score() {
        assert_eq!((1, 0), score_input("{}"));
        assert_eq!((6, 0), score_input("{{{}}}"));
        assert_eq!((5, 0), score_input("{{},{}}"));
        assert_eq!((16,0), score_input(" {{{},{},{{}}}}"));
        assert_eq!((1, 4), score_input("{<a>,<a>,<a>,<a>}"));
        assert_eq!((9, 8), score_input("{{<ab>},{<ab>},{<ab>},{<ab>}}"));
        assert_eq!((9, 0), score_input("{{<!!>},{<!!>},{<!!>},{<!!>}}"));
        assert_eq!((3, 17), score_input("{{<a!>},{<a!>},{<a!>},{<ab>}}"));
    }
}