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
  auto x = readln.split.map!(to!int);
  auto N = x[0];
  auto Q = x[1];

  foreach (q; 0..Q) {
    x = readln.split.map!(to!int);
    auto a = x[0];
    auto b = x[1];
    auto s = x[2];
    auto t = x[3];
    if (a <= s && s <= b && b <= t)
      writeln((t-b)*100);
    else if (s <= a && b <= t)
      writeln((a-s+t-b)*100);
    else if (s <= a && a <= t && t <= b)
      writeln((a-s)*100);
    else if (a <= s && t <= b)
      writeln(0);
    else
      writeln((t-s)*100);
  }

}
