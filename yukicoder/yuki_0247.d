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
  const int MAX = 10^^5*2;
  int C = readln.chomp.to!int;
  int N = readln.chomp.to!int;
  auto A = readln.split.map!(to!int).array;

  auto dp = new int[](C+1);
  foreach (i; iota(1, C+1))
    dp[i] = MAX;

  foreach (i; iota(1, C+1))
    foreach (a; A)
      if (i-a >= 0 && i-a <= C)
        dp[i] = min(dp[i], dp[i-a]+1);
  writeln(dp[C] == MAX ? -1 : dp[C]);
}

