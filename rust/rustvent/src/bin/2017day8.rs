extern crate rustvent;
extern crate regex;
use std::collections::HashMap;
use regex::Regex;


fn main() {
    let input = rustvent::get_input().expect("Must provide valid input path");
    let mut registers: HashMap<String, i32> = HashMap::new();
    let mut max_val = 0;

    for instruction in input.lines() {
        parse_instruction(&mut registers, &instruction);
        let current_max = registers.values().max().unwrap();
        if current_max > &max_val {max_val = *current_max;}
    }

    let part_1 = registers.values().max().unwrap();

    println!("part 1: max_value: {}", part_1);
    println!("part 2: all-time max value: {}", max_val);
}

fn parse_instruction(registers: &mut HashMap<String, i32>, instruction: &str) {
    let re = Regex::new(r"^(?P<key>\S*) (?P<op>\S*) (?P<i>\S*) if (?P<comp_key>\S*) (?P<comp_op>\S*) (?P<comp_i>\S*)$").unwrap();
    let caps = re.captures(&instruction).unwrap();
    let comp_i: i32 = caps["comp_i"].parse().unwrap();
    if validate_instruction(registers, &caps["comp_key"], &caps["comp_op"], comp_i) {
        let update_i: i32 = match &caps["op"] {
            "inc" => caps["i"].parse().unwrap(),
            _ => {
                let i: i32 = caps["i"].parse().unwrap();
                -i
            },
        };
        update_hash_value(registers, &caps["key"], update_i)
    }
}

fn update_hash_value(registers: &mut HashMap<String, i32>, k: &str, i: i32 ) {
    //TODO: only insert if get_mut is None...not sure how
    registers.entry(k.to_string()).or_insert(0);
    *registers.get_mut(k).unwrap() += i;
}

fn validate_instruction(registers: &mut HashMap<String, i32>, k: &str, op: &str, i: i32 ) -> bool {
    let val = registers.entry(k.to_string()).or_insert(0);
    match op {
        ">" => *val > i,
        ">=" => *val >= i,
        "==" => *val == i,
        "!=" => *val != i,
        "<" => *val < i,
        "<=" => *val <= i,
        _ => false,
    }
}


#[cfg(test)]
mod test_2017day8 {
    use super::*;
    #[test]
    fn test_update_hash_value_modifies_a_registers_value() {
        let mut test_hash: HashMap<String, i32> = HashMap::new();
        test_hash.insert("foo".to_string(), 0);
        test_hash.insert("bar".to_string(), 0);

        update_hash_value(&mut test_hash, "foo", 10);
        update_hash_value(&mut test_hash, "bar", -10);
        assert_eq!(&(10 as i32), test_hash.get("foo").unwrap());
        assert_eq!(&(-10 as i32), test_hash.get("bar").unwrap());
    }
    #[test]
    fn test_validate_instruction_inserts_new_keys_if_they_do_not_exist() {
        let mut test_hash: HashMap<String, i32> = HashMap::new();

        validate_instruction(&mut test_hash, "foo", "<", 10);
        assert_eq!(&(0 as i32), test_hash.get("foo").unwrap());
    }
    #[test]
    fn test_validate_instruction_evaluates_comparison_to_registry() {
        let mut test_hash: HashMap<String, i32> = HashMap::new();
        test_hash.insert("foo".to_string(), 10);
        test_hash.insert("bar".to_string(), -10);

        assert_eq!(false, validate_instruction(&mut test_hash, "foo", "<", 10));
        assert_eq!(true, validate_instruction(&mut test_hash, "foo", "<=", 10));
        assert_eq!(false, validate_instruction(&mut test_hash, "foo", ">", 10));
        assert_eq!(true, validate_instruction(&mut test_hash, "foo", ">=", 10));
        assert_eq!(true, validate_instruction(&mut test_hash, "foo", "==", 10));
        assert_eq!(false, validate_instruction(&mut test_hash, "foo", "!=", 10));

        assert_eq!(false, validate_instruction(&mut test_hash, "bar", "<", -10));
        assert_eq!(true, validate_instruction(&mut test_hash, "bar", "<=", -10));
        assert_eq!(false, validate_instruction(&mut test_hash, "bar", ">", -10));
        assert_eq!(true, validate_instruction(&mut test_hash, "bar", ">=", -10));
        assert_eq!(true, validate_instruction(&mut test_hash, "bar", "==", -10));
        assert_eq!(false, validate_instruction(&mut test_hash, "bar", "!=", -10));

        assert_eq!(false, validate_instruction(&mut test_hash, "baz", ">", 10));
        assert_eq!(true, validate_instruction(&mut test_hash, "hello", "==", 0));
    }
    #[test]
    fn test_parse_instruction_updates_the_hash_accordingly() {
        let mut test_hash: HashMap<String, i32> = HashMap::new();
        let instructions = vec!(
            "b inc 5 if a > 1",
            "a inc 1 if b < 5",
            "c dec -10 if a >= 1",
            "c inc -20 if c == 10");
        for instruction in instructions {parse_instruction(&mut test_hash, instruction)};

        assert_eq!(&(1 as i32), test_hash.get("a").unwrap());
        assert_eq!(&(0 as i32), test_hash.get("b").unwrap());
        assert_eq!(&(-10 as i32), test_hash.get("c").unwrap());
    }
}