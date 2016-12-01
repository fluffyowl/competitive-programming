import std.stdio;
import std.array;
import std.string;
import std.conv;
import std.algorithm;
import std.typecons;
import std.range;
import std.random;

void main() {
  auto N = readln.chomp.to!int;
  auto D = iota(N).map!(_ => readln.chomp.to!int).array.sort();
  int MOD = 10^^9+7;

  auto dp = new int[][](4, N);
  foreach (i; iota(4)) {
    foreach (j; iota(N)) {
      if (i == 0)
	dp[i][j] = 1;
      else if (j > 0)
	dp[i][j] = (dp[i][j] + dp[i][j-1]) % MOD;
      if (i < 3) {
	auto pos = D.lowerBound(D[j]*2).length;
	if (pos < N)
	  dp[i+1][pos] = (dp[i+1][pos] + dp[i][j]) % MOD;
      }
    }
  }

  int ans = 0;
  foreach (j; iota(1, N))
    ans = (ans + dp[3][j]) % MOD;

  writeln(ans);
}
