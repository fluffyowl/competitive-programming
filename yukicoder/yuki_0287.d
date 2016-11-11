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
  int N = readln.chomp.to!int;
  long[801][8] dp;

  foreach (i; iota(N+1))
    dp[0][i] = 1;

  foreach (i; iota(1, 8))
    foreach (j; iota(801))
      foreach (k; iota(N+1))
        if (j-k >= 0 && j-k <= 800)
          dp[i][j] += dp[i-1][j-k];

  writeln(dp[7][6*N]);
}

