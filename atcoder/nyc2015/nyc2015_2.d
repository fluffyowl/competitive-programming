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
import std.numeric;
import core.bitop;


void main() {
  auto N = readln.chomp.to!int;
  auto A = iota(N).map!(_ => readln.chomp.to!int).array.sort();
  int ans, acm;
  foreach (a; A)
    if (a > acm) {
      acm += a;
      ans += 1;
    }
  ans.writeln;
}
