extern crate getopts;
mod year2017;

use std::io::prelude::*;
use std::fs::File;
use getopts::Options;
use std::env;
use std::collections::HashMap;


fn print_usage(program: &str, opts: Options) {
    let brief = format!("Usage: {} -y YEAR -d DAY -p PART [-f] INPUT

examples:
cargo run -- -y 2017 -d 1 -p 1 some random input
cargo run -- -y 2017 -d 1 -p 1 -f some_random_input_file.txt

cargo run -- --year 2017 --day 1 --part 1 some random input
cargo run -- --year 2017 --day 1 --part 1 -is-file some_random_input_file.txt
", program);
    print!("{}", opts.usage(&brief));
}


const VALID_PARTS: &'static [&'static str] = &["1", "2"];

fn run_puzzle(year: String, day: String, part: String, input: String) {
	let mut puzzles = HashMap::new();
	puzzles.insert("2017-1".to_string(), year2017::day1::main);
	if VALID_PARTS.contains(&part.as_str()) {
		let puzzle_key = [year, day].join("-");
		puzzles[&puzzle_key](part, input)
	} else { println!("{} is not a valid puzzle part!", part)}
}


fn main() {
    let args: Vec<String> = env::args().collect();
    let program = args[0].clone();

    let mut opts = Options::new();
    opts.reqopt("y", "year", "year", "year");
    opts.reqopt("d", "day", "day", "day");
    opts.optopt("p", "part", "part", "part");
    opts.optflag("v", "verbose", "Echo input");
    opts.optflag("f", "is-file", "Include if input is filename (better for long / multi-line inputs)");
    opts.optflag("h", "help", "print this help menu");
    let matches = match opts.parse(&args[1..]) {
        Ok(m) => { m }
        Err(f) => { panic!(f.to_string()) }
    };
    if matches.opt_present("h") {
        print_usage(&program, opts);
        return;
    }
    let year = matches.opt_str("y").unwrap();
    let day = matches.opt_str("d").unwrap();
    let part = matches.opt_str("p").unwrap();
    let verbose = matches.opt_present("v");
    let is_file = matches.opt_present("f");
	let other_input = matches.free.clone().join(" ").trim().to_string();
	let input_string = if is_file {
		let mut input_mut = String::new();
		let mut f = File::open(other_input)
			.expect("Cannot open filename provided");

		// read the whole file
		f.read_to_string(&mut input_mut)
			.expect("Cannot read filename provided");

		input_mut
	} else if !other_input.is_empty() {
		other_input
	} else {
		print_usage(&program, opts);
		return;
	};

	let line_break = std::iter::repeat("=").take(20).collect::<String>();

    println!("{}-{} part {}", year, day, part);
	if verbose {
		println!("
puzzle_input:
{}
{}
", line_break, input_string);
}
	println!("{}", line_break);

	run_puzzle(year, day, part, input_string)
}
