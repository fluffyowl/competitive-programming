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
  
  int M = 40000;
  auto pt = new bool[](M);
  foreach (i; 2..M)
    pt[i] = true;
  foreach (i; 2..M)
    if (pt[i])
      foreach (j; iota(i+i, M, i))
        pt[j] = false;

  int[] P;
  foreach (i; 2..M)
    if (pt[i])
      P ~= i;

  auto dp = new int[](100000);
  foreach (p; P) {
    foreach (i; iota(N, -1, -1))
      if (dp[i] > 0) {
        dp[p+i] = max(dp[p+i], dp[i]+1);
      }
    dp[p] = max(dp[p], 1);
  }
  writeln(dp[N] == 0 ? -1 : dp[N]);
}

