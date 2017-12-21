extern crate rustvent;
extern crate regex;
use regex::Regex;

#[derive(Clone,PartialEq,Debug)]
struct Program {
    name: String,
    weight: u32,
    parents: Vec<String>,
}

fn main() {
    let input = rustvent::get_input().expect("Must provide valid input path");
    let part_1 = find_base_program(input.lines().collect());
    let part_2 = "bar";

    println!("part 1: find_base_program: {}", part_1.name);
    println!("part 2: {}", part_2);
}

fn extract_program(program_input: &str) -> Program {
    let re = Regex::new(r"^(?P<name>\S*) \((?P<weight>\d*)\)( -> )?(?P<parents>.*)?$").unwrap();
    let caps = re.captures(&program_input).unwrap();
    Program {name: caps["name"].to_string(),
            weight: caps["weight"].parse().unwrap(),
            parents: split_parents(&caps["parents"])
    }
}


fn find_base_program(program_inputs: Vec<&str>) -> Program {
    // find the only program with parents, but is not listed as a parent by another program
    let mut programs: Vec<Program> = vec!();
    for input in &program_inputs {
        let program = extract_program(&input);
        if !program.parents.first().unwrap().eq("") {
            programs.push(program);
        }
    }

    let p_clone = programs.clone();
    for program in p_clone {
        for parent in program.parents {
            match programs.iter().position(|p| p.name.eq(&parent)) {
                Some(result) => {
                    programs.remove(result);
                    {};
                },
                None => {},
            };
        }
    }

    assert_eq!(programs.len(), 1, "More than one base program was found!");
    programs.first().unwrap().clone()
}


fn split_parents(parents: &str) -> Vec<String> {
    parents.split(',').map(|w| w.trim().to_string()).collect()
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
        assert_eq!(Program{name: "foo".to_string(), weight: 100 as u32, parents: vec!("bar".to_string(), "baz".to_string())}, extract_program("foo (100) -> bar, baz"));
        assert_eq!(Program{name: "foo".to_string(), weight: 100 as u32, parents: vec!("".to_string())}, extract_program("foo (100)"));
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
        assert_eq!(Program{name:"tknk".to_string(), weight: 41 as u32, parents: vec!("ugml".to_string(), "padx".to_string(), "fwft".to_string())}, find_base_program(input_strings));
    }
}