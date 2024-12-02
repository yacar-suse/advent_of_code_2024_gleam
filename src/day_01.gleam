//// A module to solve day 1 of 'Advent of Code' 2024

import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile


/// Read the input file and return a list of lines of text
///
fn read_lines(path: String) -> List(String) {
  simplifile.read(path)
  |> result.unwrap("File error")
  |> string.split("\n")
}


/// Function to solve part one
///
fn total_distance(list_1: List(Int), list_2: List(Int)) -> Int {
  list.map2(list_1, list_2, fn(x, y) { int.absolute_value(x - y) })
  |> list.fold(0, int.add)
}


/// Function to solve part two
/// 
fn similarity(list_1: List(Int), list_2: List(Int)) -> Int {
  list.fold(list_1, 0, fn(score, val) {
                         list.count(list_2, fn(x) { x == val })
                         |> int.multiply(val)
                         |> int.add(score)
                       })
}

pub fn main() {
  let left_list: List(Int) = read_lines("./inputs/day_01")
                             |> list.map(string.drop_end(_, 8))
                             |> list.filter_map(int.parse(_))
                             |> list.sort(int.compare)

  let right_list: List(Int) = read_lines("./inputs/day_01")
                              |> list.map(string.drop_start(_, 8))
                              |> list.filter_map(int.parse(_))
                              |> list.sort(int.compare)

  total_distance(left_list, right_list)
  |> io.debug

  similarity(left_list, right_list)
  |> io.debug
}
