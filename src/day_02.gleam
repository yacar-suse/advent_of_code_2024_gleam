//// A module to solve day 2 of 'Advent of Code' 2024

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


/// Functions to solve part one
///
fn parse_report(report: List(Int)) -> List(Int) {
  list.map2(report, list.drop(report, 1), fn(x, y) { int.negate(x - y) })
}


fn parse_reports(reports: List(List(Int))) -> List(List(Int)) {
  list.map(reports, parse_report)
}


fn report_is_safe(report: List(Int)) -> Bool {
  case report {
    [ 1, ..rest] | [ 2, ..rest] | [ 3, ..rest] -> continues_increasing(rest)
    [-1, ..rest] | [-2, ..rest] | [-3, ..rest] -> continues_decreasing(rest)
    _ -> False
  }
}


fn continues_increasing(report: List(Int)) -> Bool {
  case report {
    [] -> True
    [ 1, ..rest] | [ 2, ..rest] | [ 3, ..rest] -> continues_increasing(rest)
    _ -> False
  }
}


fn continues_decreasing(report: List(Int)) -> Bool {
  case report {
    [] -> True
    [-1, ..rest] | [-2, ..rest] | [-3, ..rest] -> continues_decreasing(rest)
    _ -> False
  }
}


pub fn main() {
  let reports: List(List(Int)) = read_lines("./inputs/day_02")
                                 |> list.map(string.split(_, " "))
                                 |> list.map(list.filter_map(_, int.parse(_)))

  reports
  |> parse_reports
  |> list.count(report_is_safe)
  |> io.debug
}
