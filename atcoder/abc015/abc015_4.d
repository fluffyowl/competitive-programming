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
  auto W = readln.chomp.to!int;
  auto input = readln.split.map!(to!int);
  auto N = input[0];
  auto K = input[1];
  auto AB = iota(N).map!(_ => readln.split.map!(to!int).array).array;
  auto dp = new int[][][](N+1, W+1, K+1);
  
  foreach (i; 0..N)
    foreach (j; 0..W+1)
      foreach (k; 0..K+1) {
        if (j+AB[i][0] <= W && k+1 <= K) 
          dp[i+1][j+AB[i][0]][k+1] = max(dp[i+1][j+AB[i][0]][k+1],
                                         dp[i][j][k] + AB[i][1]);
        dp[i+1][j][k] = max(dp[i+1][j][k], dp[i][j][k]);
      }
  writeln(dp[N][W][K]);
}
