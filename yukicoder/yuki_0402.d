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
  int INF = 10000;
  auto input = readln.split.map!(to!int);
  int H = input[0];
  int W = input[1];
  auto B = iota(H).map!(_ => readln.chomp).array;

  auto dp = new int[][](H, W);
  foreach (i; iota(H))
    foreach (j; iota(W))
      dp[i][j] = B[i][j] == '.' ? 0 : INF;

  foreach (i; iota(H))
    foreach (j; iota(W))
      dp[i][j] = (i==0 || i==H-1 || j==0 || j==W-1) ? min(dp[i][j],1) : min(dp[i-1][j-1]+1, dp[i-1][j]+1, dp[i][j-1]+1, dp[i][j]);
  foreach (i; iota(H-1, -1, -1))
    foreach (j; iota(W))
      dp[i][j] = (i==0 || i==H-1 || j==0 || j==W-1) ? min(dp[i][j],1) : min(dp[i+1][j-1]+1, dp[i+1][j]+1, dp[i][j-1]+1, dp[i][j]);
  foreach (i; iota(H))
    foreach (j; iota(W-1, -1, -1))
      dp[i][j] = (i==0 || i==H-1 || j==0 || j==W-1) ? min(dp[i][j],1) : min(dp[i-1][j+1]+1, dp[i-1][j]+1, dp[i][j+1]+1, dp[i][j]);
  foreach (i; iota(H-1, -1, -1))
    foreach (j; iota(W-1, -1, -1))
      dp[i][j] = (i==0 || i==H-1 || j==0 || j==W-1) ? min(dp[i][j],1) : min(dp[i+1][j+1]+1, dp[i+1][j]+1, dp[i][j+1]+1, dp[i][j]);

  int ans = 0;
  foreach (i; iota(H))
    foreach (j; iota(W))
      ans = max(ans, dp[i][j]);
  writeln(ans);
}

