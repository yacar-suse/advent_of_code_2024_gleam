//// A module to solve day 3 of 'Advent of Code' 2024

import gleam/int
import gleam/io
import gleam/list
import gleam/string
import gleam/regexp
import gleam/result
import simplifile


/// Read the input file and return a list of lines of text
///
fn read_lines(path: String) -> String {
  simplifile.read(path)
  |> result.unwrap("File error")
}


fn remove_dont(memory: String) -> String {
  let assert Ok(re) = regexp.from_string("don't\\(\\)")
  let memory: String = regexp.replace(re, memory, "\n   don't()")

  let assert Ok(re) = regexp.from_string("do\\(\\)")
  let memory: String = regexp.replace(re, memory, "\n   do()")
  
  memory
  |> string.split("\n   ")
  |> list.map(fn(x) { let do = string.starts_with(x, "do()")
                      let dont = string.starts_with(x, "don't()") 
                      case do, dont {
                        True, False -> x
                        False, True -> ""
                        _, _ -> x
                      }}) 
  |> string.join("")
}


fn find_mul(memory: String) -> List(#(Int, Int)) {
  let assert Ok(re) = regexp.from_string("mul\\(\\d+,\\d+\\)")

  regexp.scan(re, memory)
  |> list.map(fn(x) { x.content })
  |> list.map(string.drop_start(_, 4))
  |> list.map(string.drop_end(_, 1))
  |> list.filter_map(string.split_once(_, ","))
  |> list.map(fn(x) { #(result.unwrap(int.parse(x.0), 0),result.unwrap(int.parse(x.1), 0)) })
}


fn mul(input: List(#(Int, Int))) -> Int {
  list.map(input, fn(x) { x.0 * x.1 })
  |> list.fold(0, int.add)
}


pub fn main() {
  let memory: String = read_lines("./inputs/day_03")
  
  // Solve part one
  find_mul(memory) 
  |> mul
  |> io.debug

  // Solve part two
  remove_dont(memory)
  |> find_mul
  |> mul
  |> io.debug
}
