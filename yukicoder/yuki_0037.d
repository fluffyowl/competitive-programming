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


void main() {
  auto T = readln.chomp.to!int;
  auto N = readln.chomp.to!int;
  auto C = readln.split.map!(to!int);
  auto V = readln.split.map!(to!int);

  auto dp = new int[](T+1);
  foreach (i; 0..N)
    foreach (j; 0..10)
      foreach (t; iota(T, -1, -1))
        if (t-C[i] >= 0 && t <= T)
          dp[t] = max(dp[t], dp[t-C[i]]+(V[i]>>j));

  writeln(dp[T]);
}

