extern crate rustvent;
extern crate regex;
use regex::Regex;

#[derive(Clone,PartialEq,Debug)]
struct Program {
    name: String,
    weight: u32,
    children: Vec<String>,
}

impl Program {
    fn has_children(&self) -> bool {
       !self.children.first().unwrap().eq(&"")
    }
}
fn main() {
    let input = rustvent::get_input().expect("Must provide valid input path");
    let part_1 = find_base_program(input.lines().collect());
//    let part_2 = find_unbalanced_node(part_1.clone(),input.lines().collect());

    println!("part 1: find_base_program: {}", part_1.name);
//    println!("part 2: unbalanced_node: {} is too heavy. Should be {}.",
//                part_2.0.name, part_2.0.weight - part_2.1);
}

fn split_children(children: &str) -> Vec<String> {
    children.split(',').map(|w| w.trim().to_string()).collect()
}

fn extract_program(program_input: &str) -> Program {
    let re = Regex::new(r"^(?P<name>\S*) \((?P<weight>\d*)\)( -> )?(?P<children>.*)?$").unwrap();
    let caps = re.captures(&program_input).unwrap();
    Program {name: caps["name"].to_string(),
            weight: caps["weight"].parse().unwrap(),
            children: split_children(&caps["children"])
    }
}

fn parse_all_programs(program_inputs: Vec<&str>) -> Vec<Program> {
    let mut programs: Vec<Program> = vec!();

    for input in &program_inputs {
        programs.push(extract_program(&input));
    }
    programs
}

fn find_base_program(program_inputs: Vec<&str>) -> Program {
    // find the only program with children, but is not listed as a child by another program
    let mut programs = parse_all_programs(program_inputs);
    let programs_clone = programs.clone();

    for program in programs_clone {
        for child in program.children {
            match programs.iter().position(|p| p.name.eq(&child)) {
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


fn find_program(program_name: String, program_inputs: Vec<&str>) -> Program {
    parse_all_programs(program_inputs)
        .iter()
        .find(|p| p.name.eq(&program_name))
        .unwrap().clone()
}


fn get_node_weight(program_name: String, mut acc: u32, program_inputs: Vec<&str>) -> (Program, u32) {
    println!("getting weight: {}", &program_name);
    let input_clone = program_inputs.clone();
    let node = find_program(program_name, program_inputs);
    let orig_node = node.clone();
    acc = acc + node.weight;
    if node.has_children() {
        for child in node.children {
            acc = get_node_weight(child, acc, input_clone.clone()).1;
        }
    }
    (orig_node, acc)
}

//fn find_unbalanced_node(program: Program, program_inputs: Vec<&str>) -> (Program, u32) {
//    // Return the node causing the problem and the diff between it and it's neighbors total weights
//    println!("{}", program.name);
//    let mut node = program.clone();
//    if node.has_chilren() {
//        let mut children: Vec<Program> = vec!();
//        for child in node.children {
//            let child_node = find_program(child, program_inputs.clone);
//            if child_node.has_children() {
//                find_unbalanced_node(child_node.clone(), program_inputs.clone());
//            }
//            else {
//                children.push(child_node.clone());
//            };
//        }
//    }
////    node.children.map(|child| {
////        if !child.eq("") {
////            let child_node = programs.iter().find(|p| p.name.eq(&child)).unwrap().clone();
////        }
////        if child_node.children
////
////
////    });
////    let child_weights: Vec<(Program, u32)> = node.children.iter()
////        .map(|child| get_node_weight(child.to_string(), 0, program_inputs.clone())).collect();
////
////    let max: u32 = child_weights.clone().iter().map(|w| w.1).max().unwrap();
////    let min: u32 = child_weights.clone().iter().map(|w| w.1).min().unwrap();
////    println!("min: {}, max{}", min, max);
////    if max > min {
////        let bad_node = child_weights.iter().find(|w| w.1.eq(&max)).unwrap().0.clone();
////        return (bad_node, max - min);
////    } else {
////        println!("{:?}", child_weights);
////        for child in child_weights {
////            return find_unbalanced_node(child.0, program_inputs.clone());
////        }
////    };
//    (node, 2)
//}


#[cfg(test)]
mod test_2017day7 {
    use super::*;
    #[test]
    fn test_split_children_returns_vec_of_names_from_child_string() {
        assert_eq!(vec!("foo", "bar"), split_children("foo, bar"));
        assert_eq!(vec!("foo", "bar", "baz"), split_children("foo, bar, baz"));
        assert_eq!(vec!("foo"), split_children("foo"));
    }
    #[test]
    fn test_extract_program_returns_program_components() {
        assert_eq!(
            Program{
                name: "foo".to_string(),
                weight: 100 as u32,
                children: vec!("bar".to_string(), "baz".to_string())},
            extract_program("foo (100) -> bar, baz"));
        assert_eq!(
            Program{
                name: "foo".to_string(),
                weight: 100 as u32,
                children: vec!("".to_string())},
            extract_program("foo (100)"));
    }
    #[test]
    fn test_parse_all_inputs_returns_vec_of_programs_from_input() {
        let input_strings = vec!(
            "fwft (72) -> ktlj, cntj",
            "foo (66)",
            "padx (45) -> foo",
            "cntj (57)");
        let expected_vec = vec!(
            Program{
                name: "fwft".to_string(),
                weight: 72 as u32,
                children: vec!("ktlj".to_string(), "cntj".to_string())},
            Program{
                name: "foo".to_string(),
                weight: 66 as u32,
                children: vec!("".to_string())},
            Program{name: "padx".to_string(),
                weight: 45 as u32,
                children: vec!("foo".to_string())},
            Program{
                name: "cntj".to_string(),
                weight: 57 as u32,
                children: vec!("".to_string())},
        );
        assert_eq!(expected_vec, parse_all_programs(input_strings));
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
        assert_eq!(
            Program{
                name:"tknk".to_string(),
                weight: 41 as u32,
                children: vec!("ugml".to_string(), "padx".to_string(), "fwft".to_string())},
            find_base_program(input_strings));
    }
    #[test]
    fn test_get_node_weight_returns_sum_of_weights_above_node() {
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

        assert_eq!(
            (
                Program{
                    name: "ugml".to_string(),
                    weight: 68 as u32,
                    children: vec!("gyxo".to_string(), "ebii".to_string(), "jptl".to_string())
                }, 251
            ),
            get_node_weight("ugml".to_string(), 0,input_strings.clone()));
        assert_eq!(
            (
                Program{
                    name: "padx".to_string(),
                    weight: 45 as u32,
                    children: vec!("pbga".to_string(), "havc".to_string(), "qoyq".to_string())
                }, 243
            ),
            get_node_weight("padx".to_string(), 0,input_strings.clone()));
    }
//    #[test]
//    fn test_find_unbalanced_node_returns_a_program_that_is_unbalanced() {
//        let input_strings = vec!(
//            "pbga (66)",
//            "xhth (57)",
//            "ebii (61)",
//            "havc (66)",
//            "ktlj (57)",
//            "fwft (72) -> ktlj, cntj, xhth",
//            "qoyq (66)",
//            "padx (45) -> pbga, havc, qoyq",
//            "tknk (41) -> ugml, padx, fwft",
//            "jptl (61)",
//            "ugml (68) -> gyxo, ebii, jptl",
//            "gyxo (61)",
//            "cntj (57)");
//        let base_program =
//            Program{
//                name:"tknk".to_string(),
//                weight: 41 as u32,
//                children: vec!("ugml".to_string(), "padx".to_string(), "fwft".to_string())};
//
//        assert_eq!(
//            (
//                Program{
//                    name:"ugml".to_string(),
//                    weight: 68 as u32,
//                    children: vec!("gyxo".to_string(), "ebii".to_string(), "jptl".to_string())},
//                8 as u32),
//            find_unbalanced_node(base_program, input_strings))
//            ;
//    }
}