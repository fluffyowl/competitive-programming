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
  const int MOD = 10^^9+9;
  int M = (10L^^10/111111L).to!int;
  auto dp = new int[][](10, M+1);
  foreach (i; 0..10)
    foreach (j; 0..M+1) {
      if (i == 0 || j == 0)
        dp[i][j] = 1;
      else if (j-i >= 0)
        dp[i][j] = (dp[i-1][j] + dp[i][j-i]) % MOD;
      else
        dp[i][j] = dp[i-1][j];
    }

  int T = readln.chomp.to!int;
  foreach (t; 0..T) {
    writeln(dp[9][(readln.chomp.to!long/111111L).to!int]);
  }
}
