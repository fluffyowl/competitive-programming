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
  auto input = readln.split.map!(to!int);
  int H = input[0];
  int A = input[1];
  int D = input[2];

  auto dp = new double[](H+1);
  dp[0] = 0.0;
  foreach (i; 1..H+1)
    dp[i] = min(1+dp[max(0, i-A)], 1.5+dp[max(0, i-D)]);
  writeln(dp[H]);
}

