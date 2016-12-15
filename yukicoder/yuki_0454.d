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


void main() {
  auto x = readln.chomp.to!real;
  real ans = 0;
  foreach (i; 1..3000000) {
    ans += 1.0L / (x + i)^^2;
  }
  ans += 1 / (x+3000000+0.5);
  writefln("%.10f", ans);
}

