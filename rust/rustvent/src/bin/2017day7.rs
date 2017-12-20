extern crate rustvent;
extern crate regex;
use regex::Regex;
use regex::Captures;

fn main() {
    let input = rustvent::get_input().expect("Must provide valid input path");
    let part_1 = find_base_program(input.lines().collect());
    let part_2 = "bar";

    println!("part 1: find_base_program: {}", part_1);
    println!("part 2: {}", part_2);
}


fn extract_program(program_input: &str) -> Captures {
    let re = Regex::new(r"^(?P<name>\S*) \((?P<weight>\d*)\)( -> )?(?P<parents>.*)?$").unwrap();
    let caps = re.captures(&program_input).unwrap();
    caps
}


fn find_base_program(program_inputs: Vec<&str>) -> String {
    // find the only program with parents, but is not listed as a parent by another program
    let mut candidates: Vec<String> = vec!();
    let mut parents: Vec<String> = vec!();
    for input in &program_inputs {
        let program = extract_program(&input);
        if !program["parents"].eq("") {
            let program_name = &program["name"];
            candidates.push(program_name.to_string());

            for parent in split_parents(&program["parents"]){
                parents.push(parent.to_string());
            }
        }
    }
    for parent in parents {
        if candidates.contains(&parent) {
            let index = candidates.iter().position(|x| *x == parent).unwrap();
            candidates.remove(index);
        }
    }
    assert_eq!(candidates.len(), 1);
    candidates.first().unwrap().to_string()
}


fn split_parents(parents: &str) -> Vec<&str> {
    parents.split(',').map(|w| w.trim()).collect()
}


#[cfg(test)]
mod test_2017day7 {
    use super::*;
    #[test]
    fn test_split_parents_returns_vec_of_names_from_parent_string() {
        assert_eq!(vec!("foo", "bar"), split_parents("foo, bar"));
        assert_eq!(vec!("foo", "bar", "baz"), split_parents("foo, bar, baz"));
        assert_eq!(vec!("foo"), split_parents("foo"));
    }
    #[test]
    fn test_extract_program_returns_program_components() {
        let caps = extract_program("foo (100) -> bar, baz");
        assert_eq!("100", &caps["weight"]);
        assert_eq!("foo", &caps["name"]);
        assert_eq!("bar, baz", &caps["parents"]);

        let caps = extract_program("foo (100)");
        assert_eq!("100", &caps["weight"]);
        assert_eq!("foo", &caps["name"]);
        assert_eq!("", &caps["parents"]);
    }
    #[test]
    fn test_find_base_program_returns_the_root_program_name() {
        let input_strings = vec!(
            "pbga (66)",
            "xhth (57)",
            "ebii (61)",
            "havc (66)",
            "ktlj (57)",
            "fwft (72) -> ktlj, cntj, xhth",
            "qoyq (66)",
            "padx (45) -> pbga, havc, qoyq",
            "tknk (41) -> ugml, padx, fwft",
            "jptl (61)",
            "ugml (68) -> gyxo, ebii, jptl",
            "gyxo (61)",
            "cntj (57)");
        assert_eq!("tknk", find_base_program(input_strings));
    }
}