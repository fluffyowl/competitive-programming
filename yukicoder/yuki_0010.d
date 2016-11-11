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
  auto N = readln.chomp.to!int;
  auto T = readln.chomp.to!int;
  auto A = readln.split.map!(to!int).array;

  auto dp = new string[][](N, T+1);
  dp[0][A[0]] = "+";
  foreach (i; iota(N-1))
    foreach (j; iota(T+1)) {
      if (dp[i][j] != "") {
        if (j * A[i+1] <= T)
          dp[i+1][j*A[i+1]] = dp[i+1][j*A[i+1]] != "" ? max(dp[i][j]~'*', dp[i+1][j*A[i+1]]) : dp[i][j]~'*';
        if (j + A[i+1] <= T)
          dp[i+1][j+A[i+1]] = dp[i+1][j+A[i+1]] != "" ? max(dp[i][j]~'+', dp[i+1][j+A[i+1]]) : dp[i][j]~'+';
      }
    }

  writeln(dp[N-1][T][1..$]);
}

