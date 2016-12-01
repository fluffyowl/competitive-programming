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


long mod = 10L^^9+7;

long solve(int div, string S) {
  auto N = S.length;
  auto dp = new long[][][](N+1, 2, div); // keta, miman, d-wareru
  dp[0][0][0] = 1L;
  foreach (i; 0..N)
    foreach (j; 0..2)
      foreach (k; 0..div) {
        auto digit = j ? 9 : (S[i]-'0').to!int;
        foreach (d; 0..digit+1)
          (dp[i+1][j||(d<digit)][(k+d)%div] += dp[i][j][k]) %= mod;
      }

  long ans = 0;
  foreach (j; 0..2)
    (ans += dp[N][j][0]) %= mod;

  return ans;
  
}

void main() {
  auto D = readln.chomp.to!int;
  auto N = readln.chomp;
  writeln((solve(D, N)-1)%mod);
}
