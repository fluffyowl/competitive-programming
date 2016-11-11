import std.stdio;
import std.array;
import std.string;
import std.conv;
import std.algorithm;
import std.typecons;
import std.range;
import std.random;
import std.math;
import std.container;

void main() {
  auto W = readln.chomp.to!int;
  auto H = readln.chomp.to!int;
  auto N = readln.chomp.to!int;
  bool[int] row;
  bool[int] col;
  foreach (i; iota(N)) {
    auto input = readln.split.map!(to!int);
    row[input[0]] = true;
    col[input[1]] = true;
  }
  writeln(col.length*W+row.length*H-(col.length*row.length)-N);
}

