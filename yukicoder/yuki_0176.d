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
import std.bigint;
import core.bitop;


void main() {
  auto input = readln.split.map!(to!long);
  auto A = input[0];
  auto B = input[1];
  auto T = input[2];
  if (T % A == 0 || T % B == 0) {writeln(T); return;}
  auto ans = long.max;
  foreach (i; 0..T/A+10) {
    auto j = T - A*i - 1 < 0 ? 0 : (T - A*i - 1) / B + 1;
    ans = min(ans, A*i+B*j);
    if (i > B) break;
  }
  writeln(ans);
}

