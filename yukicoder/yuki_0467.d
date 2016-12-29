import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
  auto N = readln.chomp.to!int;
  auto D = readln.split.map!(to!int).array;
  auto X = readln.split.map!(x => x.to!int.abs).array.reduce!(max);
  auto ans = X == 0 ? 0 : int.max;

  foreach (d; D) {
    auto a = X / d * d;
    if (d > X)             ans = min(ans, 2);
    else if (a == X)       ans = min(ans, X/d);
    else if (find(D, X-a)) ans = min(ans, X/d+1);
    else                   ans = min(ans, X/d+2);
  }

  ans.writeln;
}

